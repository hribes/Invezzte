import 'package:flutter/material.dart';

class Headerform extends StatelessWidget {
  final String title;
  final String? balanceInteger;
  final String? balanceDecimal;

  const Headerform({
    super.key,
    required this.title,
    this.balanceInteger,
    this.balanceDecimal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFB300), 
          ),
        ),
        if (balanceInteger != null) ...[
          const SizedBox(height: 16),
          const Text(
            "Saldo total da conta:",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Color(0xFFB095FF), 
                fontWeight: FontWeight.w900,
              ),
              children: [
                TextSpan(
                  text: balanceInteger,
                  style: const TextStyle(fontSize: 70),
                ),
                TextSpan(
                  text: balanceDecimal ?? "",
                  style: const TextStyle(fontSize: 28),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}