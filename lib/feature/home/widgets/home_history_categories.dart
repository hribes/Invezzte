import 'package:flutter/material.dart';

class HomeHistoryCategories extends StatelessWidget {
  final List<Map<String, dynamic>>? categorias;
  final VoidCallback onVerTudoPressed; 
  final Function(String) onCategoriaPressed; 

  const HomeHistoryCategories({
    super.key, 
    required this.categorias,
    required this.onVerTudoPressed,
    required this.onCategoriaPressed,
  });

  @override
  Widget build(BuildContext context) {
    final listaSegura = categorias ?? [];
    if (listaSegura.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text("Veja seu histórico", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

              GestureDetector(
                onTap: onVerTudoPressed,
                child: const Text("Ver tudo", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: listaSegura.map((categoria) {
              return GestureDetector(
                onTap: () => onCategoriaPressed(categoria['label']), 
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9173FF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(categoria['icon'], color: const Color(0xFFFFD54F), size: 30),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      categoria['label'],
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}