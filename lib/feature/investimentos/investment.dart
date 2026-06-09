import 'package:flutter/material.dart' hide SearchBar;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:invezzte/feature/widgets/HeaderScreens.dart';
import 'package:invezzte/feature/widgets/NavBar.dart';
import 'package:invezzte/feature/investimentos/widgets/cryptoCard.dart';
import 'package:invezzte/feature/investimentos/widgets/graphic.dart';
import 'package:invezzte/feature/investimentos/widgets/sell_modal.dart';

// Importações dos Notifiers
import 'package:invezzte/domain/notifiers/user_notifier.dart';
import 'package:invezzte/domain/notifiers/investimento_notifier.dart';
import 'package:invezzte/domain/notifiers/patrimonio_history_notifier.dart';

// Importações das Entidades
import 'package:invezzte/domain/transaction.dart';
import 'package:invezzte/domain/enums.dart';
import 'package:invezzte/core/injecao.dart';
import 'package:invezzte/domain/repositories/transaction_repository.dart';

class Investment extends StatefulWidget {
  const Investment({super.key});

  @override
  State<Investment> createState() => _InvestmentState();
}

class _InvestmentState extends State<Investment> {
  bool isLoading = false;

  String tickerSelecionado = 'PETR4';
  final List<String> tickersPermitidos = ['PETR4', 'MGLU3', 'VALE3', 'ITUB4'];
  final TextEditingController quantidadeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = context.read<UserProvider>().currentUser?.id;
      if (userId != null) {
        context.read<InvestimentoNotifier>().carregarDadosDoBanco(userId);
        // Inicializar o gráfico com o patrimônio atual
        final patrimonioInicial =
            context.read<UserProvider>().currentUser?.patrimony ?? 0.0;
        context.read<PatrimonioHistoryNotifier>().adicionarRegistro(
          patrimonioInicial,
        );
      }
    });
  }

  Future<void> adicionarNovoInvestimento() async {
    final int? quantidadeNova = int.tryParse(quantidadeController.text);

    if (quantidadeNova == null || quantidadeNova <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insira uma quantidade válida.')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final url = Uri.parse(
        'https://brapi.dev/api/quote/$tickerSelecionado?token=kAVfyCqeHFkgMGmQQ4PUQ1',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final precoAtual = data['results'][0]['regularMarketPrice'] as double;
        final valorInvestido = precoAtual * quantidadeNova;

        final userProvider = context.read<UserProvider>();
        final userId = userProvider.currentUser!.id;

        await context.read<InvestimentoNotifier>().adicionarOperacao(
          userId,
          tickerSelecionado,
          valorInvestido,
          quantidadeNova,
        );

        final patrimonioAtual = userProvider.currentUser?.patrimony ?? 0.0;
        final novoPatrimonio = patrimonioAtual + valorInvestido;

        await userProvider.atualizarPatrimonio(novoPatrimonio);

        // Adicionar ao histórico após atualizar
        context.read<PatrimonioHistoryNotifier>().adicionarRegistro(
          novoPatrimonio,
        );

        quantidadeController.clear();
      } else {
        throw Exception('Erro ao buscar cotação');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar dados da Brapi: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _abrirModalVenda(
    String ticker,
    double quantidadeDisponivel,
    int assetId,
  ) async {
    showDialog(
      context: context,
      builder: (context) => SellModal(
        ticker: ticker,
        quantidadeDisponivel: quantidadeDisponivel,
        onConfirm: (quantidadeVenda, valorVenda) async {
          await _processarVenda(assetId, quantidadeVenda, valorVenda);
        },
      ),
    );
  }

  Future<void> _processarVenda(
    int assetId,
    double quantidadeVenda,
    double valorVenda,
  ) async {
    try {
      final userProvider = context.read<UserProvider>();
      final userId = userProvider.currentUser!.id;

      // Registrar a operação de venda de ações
      await context.read<InvestimentoNotifier>().venderOperacao(
        userId,
        assetId,
        quantidadeVenda,
        valorVenda,
      );

      // Atualizar patrimônio
      final patrimonioAtual = userProvider.currentUser?.patrimony ?? 0.0;
      final novoPatrimonio = patrimonioAtual + valorVenda;
      await userProvider.atualizarPatrimonio(novoPatrimonio);

      // Adicionar saldo ao usuário
      final saldoAtual = userProvider.currentUser?.balance ?? 0.0;
      final novoSaldo = saldoAtual + valorVenda;
      await userProvider.atualizarSaldo(novoSaldo);

      // Registrar como transação de recebimento
      final transactionRepo = sl<TransactionRepository>();
      final novaTransacao = Transaction(
        id: 0,
        userId: userId,
        categoryId: 1, // Categoria padrão para recebimentos
        title: 'Venda de Ações',
        amount: valorVenda,
        date: DateTime.now(),
        type: TransactionType.income,
      );
      await transactionRepo.insert(novaTransacao);

      // Atualizar gráfico
      context.read<PatrimonioHistoryNotifier>().adicionarRegistro(
        novoPatrimonio,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ações vendidas com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao vender: $e')),
      );
    }
  }

  Widget build(BuildContext context) {
    final patrimonioOficial =
        context.watch<UserProvider>().currentUser?.patrimony ?? 0.0;
    final carteiraOficial = context
        .watch<InvestimentoNotifier>()
        .carteiraAgrupada;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 450,
              decoration: const BoxDecoration(
                color: Color(0xFFE6E0F8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                  child: Column(
                    children: [
                      const Headerscreens(
                        title: 'Investimentos',
                        firstIcon: Icons.search,
                        secondIcon: Icons.notifications,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Total de Patrimônio'),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "R\$ ${patrimonioOficial.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Align(child: Graphic()),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    DropdownButton<String>(
                      value: tickerSelecionado,
                      underline: const SizedBox(),
                      items: tickersPermitidos.map((String ticker) {
                        return DropdownMenuItem<String>(
                          value: ticker,
                          child: Text(
                            ticker,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() => tickerSelecionado = newValue!);
                      },
                    ),
                    const SizedBox(width: 15),

                    Expanded(
                      child: TextField(
                        controller: quantidadeController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Qtd (ex: 10)',
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),

                    isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : IconButton(
                            icon: const Icon(
                              Icons.add_circle,
                              color: Color(0xFF360B7A),
                              size: 30,
                            ),
                            onPressed: adicionarNovoInvestimento,
                          ),
                  ],
                ),
              ),
            ),

            ...carteiraOficial.map((ativo) {
              return Align(
                child: CryptoCard(
                  nameCrypto: ativo['name'],
                  valueCrypto: ativo['quantidade'],
                  valueCurrency: ativo['totalValue'],
                  onTap: () {},
                  onSell: () => _abrirModalVenda(
                    ativo['name'],
                    ativo['quantidade_raw'],
                    ativo['assetId'],
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
