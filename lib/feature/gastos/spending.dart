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
import 'package:invezzte/domain/enums.dart';

class Spending extends StatelessWidget {
  const Spending({super.key});

  @override
  Widget build(BuildContext context) {
    final historicoNotifier = context.watch<HistoricoNotifier>();
    final categoriaNotifier = context.watch<CategoriaNotifier>();

    final selectedCategory = historicoNotifier.selectedCategory;
    final selectedDate = historicoNotifier.selectedDate;

    final List<Transaction> transacoesExibidas = historicoNotifier.transacoes
        .where((t) {
          if (t.type == TransactionType.income) return false;

          if (t.date.day != selectedDate.day ||
              t.date.month != selectedDate.month ||
              t.date.year != selectedDate.year) {
            return false;
          }

          if (selectedCategory == 'Todas') return true;

          final cat = categoriaNotifier.categorias.firstWhere(
            (c) => c.id == t.categoryId,
            orElse: () => const Category(
              id: 0,
              userId: 0,
              name: 'Outros',
              iconName: 'help_outline',
            ),
          );

          return cat.name == selectedCategory;
        })
        .toList();

    final List<Map<String, dynamic>> transactionsAsMap = transacoesExibidas.map(
      (t) {
        final cat = categoriaNotifier.categorias.firstWhere(
          (c) => c.id == t.categoryId,
          orElse: () => const Category(
            id: 0,
            userId: 0,
            name: 'Outros',
            iconName: 'help_outline',
          ),
        );

        return {
          'title': t.title,
          'date': t.date,
          'category': cat.name,
          'amount': t.amount,
          'icon': cat.icon,
        };
      },
    ).toList();

    final double totalAmount = transacoesExibidas.fold(
      0,
      (sum, item) => sum + item.amount,
    );

    final Map<String, double> gastosPorCategoria = {};

    for (var t in transacoesExibidas) {
      final cat = categoriaNotifier.categorias.firstWhere(
        (c) => c.id == t.categoryId,
        orElse: () => const Category(
          id: 0,
          userId: 0,
          name: 'Outros',
          iconName: 'help_outline',
        ),
      );

      if (cat.name != 'Receitas') {
        gastosPorCategoria[cat.name] =
            (gastosPorCategoria[cat.name] ?? 0) + t.amount;
      }
    }

    final List<Map<String, dynamic>> dadosParaGrafico = gastosPorCategoria
        .entries
        .map((entry) {
          return {'category': entry.key, 'amount': entry.value};
        })
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SpendingHeader(
                total: totalAmount,
                transactions: dadosParaGrafico,
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
