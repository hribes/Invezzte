import 'package:flutter/material.dart' hide SearchBar;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:invezzte/feature/widgets/HeaderScreens.dart';
import 'package:invezzte/feature/widgets/NavBar.dart';
import 'package:invezzte/feature/investimentos/widgets/buildCryptocurrencies.dart';
import 'package:invezzte/feature/investimentos/widgets/cryptoCard.dart';
import 'package:invezzte/feature/investimentos/widgets/graphic.dart';

class Investment extends StatefulWidget {
  const Investment({super.key});

  @override
  State<Investment> createState() => _InvestmentState();
}

class _InvestmentState extends State<Investment> {
  // 1. Variáveis de Estado
  double totalPatrimonio = 98548.11; // Seu saldo base
  bool isLoading = false;

  String tickerSelecionado = 'PETR4';
  final List<String> tickersPermitidos = ['PETR4', 'MGLU3', 'VALE3', 'ITUB4'];
  final TextEditingController quantidadeController = TextEditingController();

  // Deixamos a lista vazia para remover o Bitcoin
  List<Map<String, dynamic>> ativosAdicionados = [];

  // 2. Função para buscar o preço na Brapi e atualizar o saldo
  Future<void> adicionarNovoInvestimento() async {
    final int? quantidadeNova = int.tryParse(quantidadeController.text);

    if (quantidadeNova == null || quantidadeNova <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insira uma quantidade válida.')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final url = Uri.parse(
        'https://brapi.dev/api/quote/$tickerSelecionado?token=kAVfyCqeHFkgMGmQQ4PUQ1',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final precoAtual = data['results'][0]['regularMarketPrice'] as double;

        final valorInvestido = precoAtual * quantidadeNova;

        setState(() {
          // 1. Atualiza o patrimônio total
          totalPatrimonio += valorInvestido;

          // 2. Verifica se a ação já existe na lista
          int indexExistente = ativosAdicionados.indexWhere(
            (ativo) => ativo['name'] == tickerSelecionado,
          );

          if (indexExistente != -1) {
            // Se já existe, soma a quantidade e o valor total
            int quantidadeAnterior =
                ativosAdicionados[indexExistente]['quantidade_raw'];
            int novaQuantidadeTotal = quantidadeAnterior + quantidadeNova;

            double valorAnterior =
                ativosAdicionados[indexExistente]['totalValue'];

            ativosAdicionados[indexExistente] = {
              'name': tickerSelecionado,
              'quantidade_raw': novaQuantidadeTotal,
              'quantidade': '$novaQuantidadeTotal cotas',
              'totalValue': valorAnterior + valorInvestido,
            };
          } else {
            // Se não existe, adiciona como um novo item
            ativosAdicionados.add({
              'name': tickerSelecionado,
              'quantidade_raw':
                  quantidadeNova, // Guardamos o número puro para facilitar a soma depois
              'quantidade': '$quantidadeNova cotas',
              'totalValue': valorInvestido,
            });
          }

          quantidadeController.clear();
        });
      } else {
        throw Exception('Erro ao buscar cotação');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar dados da Brapi: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container Superior com Saldo e Gráfico
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
                          // Formatando o valor atualizado reativamente
                          "R\$${totalPatrimonio.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF434343),
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

            // 3. BARRA DE ADIÇÃO DE INVESTIMENTO
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
                    // Dropdown para escolher a ação
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
                        setState(() {
                          tickerSelecionado = newValue!;
                        });
                      },
                    ),
                    const SizedBox(width: 15),

                    // Input de Quantidade
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

                    // Botão de Adicionar ou Loading
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

            // Lista Horizontal de Categorias (Mantida igual)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: SizedBox(
                height: 40,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Criptomoedas(texto: 'BitCoin', onTap: () {}),
                    Criptomoedas(texto: 'Renda fixa', onTap: () {}),
                    Criptomoedas(texto: 'FIIS', onTap: () {}),
                    Criptomoedas(texto: 'Renda Variável', onTap: () {}),
                  ],
                ),
              ),
            ),

            // 4. LISTAGEM DINÂMICA DOS CARDS
            // O spread operator (...) pega a lista de mapas e transforma em uma lista de CryptoCards
            ...ativosAdicionados.map((ativo) {
              return Align(
                child: CryptoCard(
                  nameCrypto: ativo['name'],
                  valueCrypto: ativo['quantidade'],
                  valueCurrency: ativo['totalValue'],
                  onTap: () {},
                ),
              );
            }).toList(),

            const SizedBox(height: 20), // Espaço extra no final
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
