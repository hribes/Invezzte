import 'package:flutter/material.dart';
import 'package:invezzte/feature/widgets/HeaderScreens.dart';
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
      decoration: const BoxDecoration(
        color: Color(0xFFE6E0F8),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),

      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 40), 
          child: Column(
            children: [
              Headerscreens(
                title: 'Gastos',
                firstIcon: Icons.search,
                secondIcon: Icons.notifications,
              ),
              
              const SizedBox(height: 30),
              
              Center(
                child: SpendingChart(
                  total: total,
                  transactions: transactions,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}