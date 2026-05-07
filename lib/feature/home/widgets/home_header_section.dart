import 'package:flutter/material.dart';
import 'package:invezzte/feature/widgets/HeaderScreens.dart';

class HomeHeaderSection extends StatelessWidget {
  final String nomeUsuario;
  final double saldo;
  final bool isSaldoVisivel;
  final VoidCallback onToggleSaldo;
  final VoidCallback onAddPressed;
  final VoidCallback onNotificationPressed; 

  const HomeHeaderSection({
    super.key,
    required this.nomeUsuario,
    required this.saldo,
    required this.isSaldoVisivel,
    required this.onToggleSaldo,
    required this.onAddPressed,
    required this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 60, 25, 40),
      decoration: const BoxDecoration(
        color: Color(0xFFE6E0F8),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Headerscreens(
            title: "Olá,\n$nomeUsuario!",
            firstIcon: Icons.notifications,
            onFirstIconTap: onNotificationPressed, 
          ),
          const SizedBox(height: 30),
          
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFF9173FF),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: onToggleSaldo, 
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8162F0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSaldoVisivel ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          color: const Color(0xFFFFD54F),
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Saldo",
                          style: TextStyle(color: Color(0xFFFFD54F), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isSaldoVisivel ? "R\$ ${saldo.toStringAsFixed(2).replaceAll('.', ',')}" : "••••••••",
                      style: const TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: onAddPressed, 
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 35),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}