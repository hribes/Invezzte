import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invezzte/feature/widgets/CategorySelector.dart';
import 'package:invezzte/feature/widgets/HeaderScreens.dart';
import 'package:invezzte/feature/widgets/InfoCard.dart';
import 'package:invezzte/feature/widgets/NavBar.dart';
import 'package:invezzte/domain/notifiers/historico_notifier.dart';
import 'package:invezzte/domain/notifiers/categoria_notifier.dart';
import 'package:invezzte/domain/notifiers/user_notifier.dart';
import 'package:invezzte/domain/notifiers/saldo_notifier.dart';
import 'package:invezzte/domain/transaction.dart';
import 'package:invezzte/domain/enums.dart';
import 'package:invezzte/domain/category.dart'; 

class History extends StatefulWidget {
  final String? initialCategoryName;
  const History({super.key, this.initialCategoryName});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _atualizarFiltroPeloParametro();
  }

  @override
  void didUpdateWidget(covariant History oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialCategoryName != widget.initialCategoryName) {
      _atualizarFiltroPeloParametro();
    }
  }

  void _atualizarFiltroPeloParametro() {
    if (widget.initialCategoryName != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final categoriaNotifier = context.read<CategoriaNotifier>();
        final index = categoriaNotifier.categorias.indexWhere(
          (c) => c.name == widget.initialCategoryName,
        );

        if (index != -1 && (index + 1) != _selectedCategoryIndex) {
          setState(() {
            _selectedCategoryIndex = index + 1;
          });
        }
      });
    }
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'home': return Icons.home;
      case 'directions_car': return Icons.directions_car;
      case 'shopping_cart': return Icons.shopping_cart;
      case 'restaurant': return Icons.restaurant;
      case 'work': return Icons.work;
      case 'account_balance_wallet': return Icons.account_balance_wallet;
      case 'fitness_center': return Icons.fitness_center;
      case 'local_hospital': return Icons.local_hospital;
      case 'plane': return Icons.flight;
      case 'school': return Icons.school;
      case 'entertainment': return Icons.live_tv;
      case 'attach_money': return Icons.attach_money;
      default: return Icons.help_outline;
    }
  }

  Future<void> _deletarTransacao(Transaction t) async {
    final userProvider = context.read<UserProvider>();
    final saldoAtual = userProvider.currentUser!.balance ?? 0.0;

    final novoSaldo = t.type == TransactionType.expense
        ? saldoAtual + t.amount
        : saldoAtual - t.amount;

    await userProvider.atualizarSaldo(novoSaldo);
    await context.read<HistoricoNotifier>().deletarTransacao(t.id, t.userId);
    await context.read<SaldoNotifier>().carregarSaldo();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Transação apagada com sucesso.'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoriaNotifier = context.watch<CategoriaNotifier>();
    final historicoNotifier = context.watch<HistoricoNotifier>();

    if (categoriaNotifier.categorias.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final listaBotoes = [
      CategoryItem(title: 'Todas', icon: Icons.list_alt),
      ...categoriaNotifier.categorias.map((c) => CategoryItem(
            title: c.name,
            icon: _getIconData(c.iconName),
          ))
    ];

    if (_selectedCategoryIndex >= listaBotoes.length) {
      _selectedCategoryIndex = 0;
    }

    List<Transaction> transacoesExibidas;
    String tituloSessao;

    if (_selectedCategoryIndex == 0) {
      transacoesExibidas = historicoNotifier.transacoes;
      tituloSessao = 'Todas as Transações';
    } else {

      final categoriaAtual = categoriaNotifier.categorias[_selectedCategoryIndex - 1];
      transacoesExibidas = historicoNotifier.transacoes
          .where((t) => t.categoryId == categoriaAtual.id)
          .toList();
      tituloSessao = categoriaAtual.name;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      bottomNavigationBar: const NavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Headerscreens(title: 'Histórico', firstIcon: Icons.search),
              const SizedBox(height: 30),

              CategorySelector(
                categories: listaBotoes,
                selectedIndex: _selectedCategoryIndex,
                onCategorySelected: (index) =>
                    setState(() => _selectedCategoryIndex = index),
              ),

              const SizedBox(height: 30),

              Text(
                tituloSessao,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

            const SizedBox(height: 16),

              if (transacoesExibidas.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: Text(
                      "Nenhuma transação encontrada.",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ),

              ...transacoesExibidas.map((t) {
      
                final categoriaDaTransacao = categoriaNotifier.categorias.firstWhere(
                  (c) => c.id == t.categoryId,
                  orElse: () => const Category(id: 0, userId: 0, name: 'Outros', iconName: 'help_outline')
                );

                return Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Dismissible(
                    key: Key(t.id.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) => _deletarTransacao(t),
                    child: InfoCard(
                      title: t.title,
                      date: "${t.date.day.toString().padLeft(2, '0')}/${t.date.month.toString().padLeft(2, '0')}/${t.date.year}",
                      icon: _getIconData(categoriaDaTransacao.iconName), 
                      amount: t.amount,
                      type: t.type,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}