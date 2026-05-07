import 'package:flutter/material.dart' hide SearchBar;
import 'package:invezzte/feature/widgets/NavBar.dart';
import 'package:invezzte/feature/gastos/widgets/spending_header.dart';
import 'package:invezzte/feature/gastos/widgets/spending_filter_list.dart';
import 'package:invezzte/feature/gastos/widgets/spending_date_header.dart';
import 'package:invezzte/feature/gastos/widgets/spending_transactions_list.dart';


class Spending extends StatefulWidget {
  const Spending({super.key});

  @override
  State<Spending> createState() => _SpendingState();
}

class _SpendingState extends State<Spending> {
  final List<Map<String, dynamic>> _allTransactions = [
    {'title': 'Água', 'date': DateTime(2026, 1, 2), 'category': 'Trabalho', 'amount': 130.98, 'icon': Icons.water_drop},
    {'title': 'Internet', 'date': DateTime(2026, 1, 10), 'category': 'Trabalho', 'amount': 100.74, 'icon': Icons.wifi},
    {'title': 'Curso Python', 'date': DateTime(2026, 1, 5), 'category': 'Educação', 'amount': 432.75, 'icon': Icons.school},
  ];

  DateTime _selectedDate = DateTime(2026, 1, 1);
  String _selectedCategory = 'Todas';

  @override
  Widget build(BuildContext context) {
    final filteredTransactions = _allTransactions.where((tx) {
      final bool categoryMatch = _selectedCategory == 'Todas' || tx['category'] == _selectedCategory;
      final bool dateMatch = tx['date'].month == _selectedDate.month && tx['date'].year == _selectedDate.year;
      return categoryMatch && dateMatch;
    }).toList();

    final double totalAmount = filteredTransactions.fold(0, (sum, item) => sum + item['amount']);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SpendingHeader(total: totalAmount, transactions: filteredTransactions),
              
              const SizedBox(height: 24),
              
              SpendingFilterList(
                currentCategory: _selectedCategory,
                onCategoryChanged: (newCategory) {
                  setState(() => _selectedCategory = newCategory);
                },
              ),

              SpendingDateHeader(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) {
                  setState(() => _selectedDate = newDate);
                },
              ),

              SpendingTransactionsList(transactions: filteredTransactions),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}