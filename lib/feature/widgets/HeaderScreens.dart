import 'package:flutter/material.dart';

class Headerscreens extends StatelessWidget {
  final String title;
  final IconData? firstIcon;
  final IconData? secondIcon;


  const Headerscreens({
    super.key,
    required this.title,
    this.firstIcon,
    this.secondIcon,
  });

  Widget _buildHeaderButton(IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(
            0xFF9173FF,
          ), // Fundo roxinho claro
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: const Color(0xFFFFD54F), // Sua cor roxa
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
                _buildHeaderButton(firstIcon!, null),

              if (firstIcon != null && secondIcon != null)
                const SizedBox(width: 12),

              if (secondIcon != null)
                _buildHeaderButton(secondIcon!, null),
            ],
          ),
      ],
    );
  }
}
