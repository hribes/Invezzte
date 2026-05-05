import 'package:flutter/material.dart';
import 'spending_transaction_card.dart';

class SpendingTransactionsList extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const SpendingTransactionsList({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24.0),
        child: Text("Nenhuma despesa encontrada para este filtro.", style: TextStyle(color: Colors.grey)),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: transactions.map((tx) {
          // Extraindo a data para formatar na tela
          final DateTime date = tx['date'];
          final String formattedDate = "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";

          return SpendingTransactionCard(
            icon: tx['icon'],
            iconColor: const Color(0xFF9181F4), // Pode vir do mapa tx se preferir
            title: tx['title'],
            dueDate: formattedDate,
            amount: 'R\$${tx['amount'].toStringAsFixed(2).replaceAll('.', ',')}',
          );
        }).toList(),
      ),
    );
  }
}