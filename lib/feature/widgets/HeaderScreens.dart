import 'package:flutter/material.dart';

class Headerscreens extends StatelessWidget {
  final String title;
  final IconData? firstIcon;
  final IconData? secondIcon;
  final VoidCallback? onFirstIconTap; 
  final VoidCallback? onSecondIconTap;


  const Headerscreens({
    super.key,
    required this.title,
    this.firstIcon,
    this.secondIcon,
    this.onFirstIconTap, // 2. Adicionamos no construtor
    this.onSecondIconTap, // 2. Adicionamos no construtor
  });

  Widget _buildHeaderButton(IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(
            0xFFB095FF,
          ).withOpacity(0.2), 
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: const Color(0xFF8F64FF), 
          size: 24,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        if (firstIcon != null || secondIcon != null)
          Row(
            children: [
              if (firstIcon != null)
                // 4. Passamos a função onFirstIconTap aqui!
                _buildHeaderButton(firstIcon!, onFirstIconTap),

              if (firstIcon != null && secondIcon != null)
                const SizedBox(width: 12),

              if (secondIcon != null)
                // 4. Passamos a função onSecondIconTap aqui!
                _buildHeaderButton(secondIcon!, onSecondIconTap),
            ],
          ),
      ],
    );
  }
}