import 'package:flutter/material.dart';
import 'spending_transaction_card.dart';

class SpendingTransactionsList extends StatelessWidget {
  // Apenas declare a variável que o widget recebe
  final List<Map<String, dynamic>> transactions;

  const SpendingTransactionsList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24.0),
        child: Text(
          "Nenhuma despesa encontrada para este filtro.",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: transactions.map((tx) {
          // O processamento de formatação fica aqui dentro,
          // já que o mapa já chegou pronto do Spending.dart
          final DateTime date = tx['date'] as DateTime;
          final String formattedDate =
              "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";

          return SpendingTransactionCard(
            icon: tx['icon'] as IconData,
            iconColor: const Color(0xFF9181F4),
            title: tx['title'] as String,
            dueDate: formattedDate,
            amount:
                'R\$${(tx['amount'] as double).toStringAsFixed(2).replaceAll('.', ',')}',
          );
        }).toList(),
      ),
    );
  }
}
