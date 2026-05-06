import 'package:flutter/material.dart';

// 1. Criamos um Enum para definir os tipos de transação
enum TransactionType { entrada, saida, neutro }

class InfoCard extends StatelessWidget {
  final String title;
  final String date;
  final IconData icon;
  final double amount; // Recebe o valor como número (ex: 30.00)
  final TransactionType type;

  const InfoCard({
    super.key,
    required this.title,
    required this.date,
    required this.icon,
    required this.amount,
    this.type = TransactionType.neutro, // Se não informar nada, fica preto por padrão
  });

  @override
  Widget build(BuildContext context) {
    // 2. Lógica para definir Cor e Prefixo automaticamente
    Color valueColor;
    String prefix;

    switch (type) {
      case TransactionType.entrada:
        valueColor = const Color(0xFF34C759); // Verde Vibrante
        prefix = '+R\$';
        break;
      case TransactionType.saida:
        valueColor = const Color(0xFFFF3B30); // Vermelho
        prefix = '-R\$';
        break;
      case TransactionType.neutro:
      default:
        valueColor = Colors.black; // Preto
        prefix = 'R\$'; // Sem sinal de + ou -
        break;
    }

    // 3. Formata o valor trocando ponto por vírgula (padrão BR)
    String formattedAmount = amount.toStringAsFixed(2).replaceAll('.', ',');

    return Container(
      margin: const EdgeInsets.only(bottom: 10), // Espaçamento entre as caixinhas
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04), // Aquela sombrinha suave do seu print
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Ícone roxo redondo
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF8C4EFF), // Aquele roxo padrão do seu app
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16),
          
          // Textos (Título e Data)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          
          // Valor final formatado e com a cor certa!
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