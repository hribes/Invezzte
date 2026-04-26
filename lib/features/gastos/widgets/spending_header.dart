import 'package:flutter/material.dart';
import 'spending_chart.dart';

class SpendingHeader extends StatelessWidget {
  const SpendingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container( //Espaço roxo
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
              )
            ],
          ),

          const SizedBox(height: 60),

          const Center(
            child: SpendingChart(), 
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
      child: Icon(
        icon, 
        color: const Color(0xFFFFD700), 
        size: 24),
    );
  }
}


