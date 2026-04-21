import 'package:flutter/material.dart';

class Criptomoedas extends StatelessWidget {
  final String texto;
  final VoidCallback onTap;

  const Criptomoedas({super.key, required this.texto, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: FilledButton.tonal(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 223, 223, 223),
          elevation: 0,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: Text(texto, style: const TextStyle(color: Color(0xFF434343))),
      ),
    );
  }
}
