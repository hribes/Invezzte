import 'package:flutter/material.dart';

class SpendingTransactionCard extends StatelessWidget {
  // Parâmetros (as "colunas" da nossa tabela de dados)
  final IconData icon;
  final Color iconColor;
  final String title;
  final String dueDate;
  final String amount;

  const SpendingTransactionCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.dueDate,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12), // Espaço entre os cartões
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 1. Ícone
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 16),
          
          // 2. Textos (Empilhados com Column)
          Expanded( // O Expanded empurra o valor em R$ para a ponta direita
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Vencimento: $dueDate',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          
          // 3. Valor
          Text(
            amount,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}