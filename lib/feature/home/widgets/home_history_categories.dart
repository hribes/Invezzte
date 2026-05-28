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

    return Column(
      children: [
        // Cabeçalho mantido fora do scroll
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "Veja seu histórico",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: onVerTudoPressed,
                child: const Text(
                  "Ver tudo",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),

        // IMPLEMENTAÇÃO DA ROLAGEM HORIZONTAL
        SizedBox(
          height: 120, // Altura necessária para o ícone + texto + espaçamento
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Habilita o scroll lateral
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: listaSegura.map((categoria) {
                return Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                  ), // Espaçamento entre os itens
                  child: GestureDetector(
                    onTap: () =>
                        onCategoriaPressed(categoria['label'] as String),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: const Color(0xFF9173FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            categoria['icon'] as IconData, // Conversão de tipo
                            color: const Color(0xFFFFD54F),
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          categoria['label'] as String, // Conversão de tipo
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
