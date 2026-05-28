import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invezzte/domain/notifiers/categoria_notifier.dart';
import 'package:invezzte/feature/widgets/HeaderScreens.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriaNotifier = context.watch<CategoriaNotifier>();
    final categorias = categoriaNotifier.categorias;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.close, color: Colors.grey, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 20),
              const Headerscreens(
                title: 'Categorias',
                firstIcon: Icons.search,
                secondIcon: Icons.notifications,
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: categorias.length,
                  itemBuilder: (context, index) {
                    final cat = categorias[index];
                    return CategoryItem(title: cat.name, icon: cat.icon);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// DEFINIÇÃO DO WIDGET AQUI NO MESMO ARQUIVO
class CategoryItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const CategoryItem({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF8B66FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Color(0xFF8B66FF)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Color(0xFFFFC107)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
