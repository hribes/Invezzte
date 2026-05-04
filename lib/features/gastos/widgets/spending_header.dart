import 'package:flutter/material.dart';
import 'spending_chart.dart';

class SpendingHeader extends StatelessWidget {
  final double total;
  final List<Map<String, dynamic>> transactions;

  const SpendingHeader({
    super.key,
    required this.total,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
      decoration: const BoxDecoration(
        color: Color(0xFFD1C4FF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Gastos',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  _buildHeaderButton(Icons.search),
                  const SizedBox(width: 12),
                  _buildHeaderButton(Icons.notifications_none),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          
          // Gráfico agora recebe os dados para se renderizar sozinho
          Center(
            child: SpendingChart(
              total: total,
              transactions: transactions,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF9181F4),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: const Color(0xFFFFD700), size: 24),
    );
  }
}