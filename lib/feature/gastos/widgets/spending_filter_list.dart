import 'package:flutter/material.dart';

class SpendingFilterList extends StatelessWidget {
  final String currentCategory;
  final ValueChanged<String> onCategoryChanged;

  SpendingFilterList({
    super.key,
    required this.currentCategory,
    required this.onCategoryChanged,
  });

  final List<String> filters = ['Todas', 'Transporte', 'Educação', 'Trabalho'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final isSelected = currentCategory == filters[index];

          return GestureDetector(
            onTap: () {
              // Avisa a tela principal qual filtro foi clicado
              onCategoryChanged(filters[index]);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFCE7A1) : const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  filters[index],
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    decoration: isSelected ? TextDecoration.underline : TextDecoration.none,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}