import 'package:flutter/material.dart';

// Classe simples para definir o que uma categoria precisa ter
class CategoryItem {
  final String title;
  final IconData icon;

  CategoryItem({required this.title, required this.icon});
}

class CategorySelector extends StatelessWidget {
  final List<CategoryItem> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(categories.length, (index) {
        final isSelected = selectedIndex == index;
        final category = categories[index];

        return GestureDetector(
          onTap: () => onCategorySelected(index),
          child: Column(
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  // Fundo amarelinho se selecionado, cinza se não
                  color: isSelected ? const Color(0xFFFFEAC1) : const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  category.icon, 
                  color: const Color(0xFFFFB300), // Ícone sempre amarelo/laranja
                  size: 32,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                category.title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}