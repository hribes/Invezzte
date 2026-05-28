import 'package:flutter/material.dart';

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
    // SingleChildScrollView com Row permite que o usuário arraste para o lado
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(categories.length, (index) {
          final isSelected = selectedIndex == index;
          final category = categories[index];

          return Padding(
            // Adiciona um espaçamento à direita de cada item, exceto o último
            padding: EdgeInsets.only(
              right: index == categories.length - 1 ? 0 : 16,
            ),
            child: GestureDetector(
              onTap: () => onCategorySelected(index),
              child: Column(
                children: [
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFFFEAC1)
                          : const Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      category.icon,
                      color: const Color(0xFFFFB300),
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected ? Colors.black : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
