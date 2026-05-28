import 'package:flutter/material.dart';
// Importe o arquivo correto (ajuste o caminho se necessário, mas geralmente é sem o /lib/)
import 'package:invezzte/domain/enums.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String date;
  final IconData icon;
  final double amount;
  final TransactionType type;

  const InfoCard({
    super.key,
    required this.title,
    required this.date,
    required this.icon,
    required this.amount,
    // Aqui usamos o TransactionType que vem do seu arquivo de enums
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Color valueColor;
    String prefix;

    // Ajuste aqui para os nomes que estão no seu arquivo de enums oficial
    switch (type) {
      case TransactionType.income: // Ajustado conforme seu enum original
        valueColor = const Color(0xFF34C759);
        prefix = '+R\$';
        break;
      case TransactionType.expense: // Ajustado conforme seu enum original
        valueColor = const Color(0xFFFF3B30);
        prefix = '-R\$';
        break;
      default:
        valueColor = Colors.black;
        prefix = 'R\$';
        break;
    }

    String formattedAmount = amount.toStringAsFixed(2).replaceAll('.', ',');

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF8C4EFF),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            '$prefix$formattedAmount',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
