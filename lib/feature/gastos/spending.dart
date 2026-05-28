import 'package:flutter/material.dart' hide SearchBar;
import 'package:provider/provider.dart';
import 'package:invezzte/domain/notifiers/historico_notifier.dart';
import 'package:invezzte/feature/widgets/NavBar.dart';
import 'package:invezzte/feature/gastos/widgets/spending_header.dart';
import 'package:invezzte/feature/gastos/widgets/spending_filter_list.dart';
import 'package:invezzte/feature/gastos/widgets/spending_date_header.dart';
import 'package:invezzte/feature/gastos/widgets/spending_transactions_list.dart';
import 'package:invezzte/domain/notifiers/categoria_notifier.dart';
import 'package:invezzte/domain/category.dart';
import 'package:invezzte/domain/transaction.dart';

class Spending extends StatelessWidget {
  const Spending({super.key});

  @override
  Widget build(BuildContext context) {
    final historicoNotifier = context.watch<HistoricoNotifier>();
    final categoriaNotifier = context.watch<CategoriaNotifier>();
    final filteredTransactions = historicoNotifier.despesasFiltradas;
    final List<Transaction> transacoesExibidas =
        historicoNotifier.despesasFiltradas;

    final List<Map<String, dynamic>> transactionsAsMap = transacoesExibidas.map(
      (t) {
        // Busca a categoria correspondente no Notifier pelo ID
        final cat = categoriaNotifier.categorias.firstWhere(
          (c) => c.id == t.categoryId,
          // CORREÇÃO: Usar os parâmetros que existem na classe Category
          orElse: () => const Category(
            id: 0,
            userId: 0,
            name: 'Outros',
            iconName: 'help_outline', // O construtor pede iconName, não icon
          ),
        );

        return {
          'title': t.title,
          'date': t.date,
          'category': cat.name,
          'amount': t.amount,
          'icon': cat.icon, // O getter 'cat.icon' funciona aqui perfeitamente
        };
      },
    ).toList();

    final double totalAmount = filteredTransactions.fold(
      0,
      (sum, item) => sum + item.amount,
    );

    final historicoNotifierTeste = context.watch<HistoricoNotifier>();
    print(
      "1. Total de transações no Notifier: ${historicoNotifierTeste.transacoes.length}",
    );
    print(
      "2. Categoria selecionada no Notifier: ${historicoNotifier.selectedCategory}",
    );
    print(
      "3. Despesas filtradas encontradas: ${historicoNotifier.despesasFiltradas.length}",
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SpendingHeader(
                total: totalAmount,
                transactions: transactionsAsMap,
              ),
              const SizedBox(height: 24),
              SpendingFilterList(
                currentCategory: historicoNotifier.selectedCategory,
                onCategoryChanged: (newCategory) {
                  historicoNotifier.setCategory(newCategory);
                },
              ),
              SpendingDateHeader(
                selectedDate: historicoNotifier.selectedDate,
                onDateChanged: (newDate) {
                  historicoNotifier.setDate(newDate);
                },
              ),
              SpendingTransactionsList(transactions: transactionsAsMap),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
