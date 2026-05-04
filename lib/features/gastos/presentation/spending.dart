import 'package:flutter/material.dart' hide SearchBar;
import 'package:invezzte/core/widgets/NavBar.dart';
import 'package:invezzte/features/gastos/widgets/spending_header.dart';
import 'package:invezzte/features/gastos/widgets/spending_filter_list.dart';
import 'package:invezzte/features/gastos/widgets/spending_date_header.dart';
import 'package:invezzte/features/gastos/widgets/spending_transactions_list.dart';

// No arquivo spending.dart

class Spending extends StatefulWidget {
  const Spending({super.key});

  @override
  State<Spending> createState() => _SpendingState();
}

class _SpendingState extends State<Spending> {
  // 1. DADOS MESTRES (Simulando um banco de dados)
  final List<Map<String, dynamic>> _allTransactions = [
    {'title': 'Água', 'date': DateTime(2026, 1, 2), 'category': 'Trabalho', 'amount': 130.98, 'icon': Icons.water_drop},
    {'title': 'Internet', 'date': DateTime(2026, 1, 10), 'category': 'Trabalho', 'amount': 100.74, 'icon': Icons.wifi},
    {'title': 'Curso Python', 'date': DateTime(2026, 1, 5), 'category': 'Educação', 'amount': 432.75, 'icon': Icons.school},
  ];

  // 2. ESTADOS DE FILTRO
  DateTime _selectedDate = DateTime(2026, 1, 1);
  String _selectedCategory = 'Todas';

  @override
  Widget build(BuildContext context) {
    // 3. LÓGICA DE FILTRAGEM (Data Science na prática)
    // Filtramos a lista baseada na categoria e no mês/ano da data selecionada
    final filteredTransactions = _allTransactions.where((tx) {
      final bool categoryMatch = _selectedCategory == 'Todas' || tx['category'] == _selectedCategory;
      final bool dateMatch = tx['date'].month == _selectedDate.month && tx['date'].year == _selectedDate.year;
      return categoryMatch && dateMatch;
    }).toList();

    // 4. CÁLCULO DO TOTAL
    final double totalAmount = filteredTransactions.fold(0, (sum, item) => sum + item['amount']);

    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Passamos o total e os dados para o Header
              SpendingHeader(total: totalAmount, transactions: filteredTransactions),
              
              const SizedBox(height: 24),
              
              // Passamos uma função para atualizar a categoria
              SpendingFilterList(
                currentCategory: _selectedCategory,
                onCategoryChanged: (newCategory) {
                  setState(() => _selectedCategory = newCategory);
                },
              ),

              // Passamos a data e a função de mudança
              SpendingDateHeader(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) {
                  setState(() => _selectedDate = newDate);
                },
              ),

              // Passamos a lista filtrada para os cards
              SpendingTransactionsList(transactions: filteredTransactions),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}