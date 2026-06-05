import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invezzte/domain/notifiers/categoria_notifier.dart';

class SpendingFilterList extends StatelessWidget {
  final String currentCategory;
  final ValueChanged<String> onCategoryChanged;

  const SpendingFilterList({
    super.key,
    required this.currentCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final categoriaNotifier = context.watch<CategoriaNotifier>();
    final categoriasDespesa = categoriaNotifier.categorias.where((cat) => cat.name != 'Receitas').toList();
    
    final List<String> filters = ['Todas', ...categoriasDespesa.map((c) => c.name)];

    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filterName = filters[index];
          final isSelected = currentCategory == filterName;

          return GestureDetector(
            onTap: () {
              onCategoryChanged(filterName);
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
                  filterName,
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