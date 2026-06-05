import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart'; // Adicionado para a navegação!
import 'package:invezzte/domain/category.dart';
import 'package:invezzte/domain/notifiers/categoria_notifier.dart';
import 'package:invezzte/domain/notifiers/historico_notifier.dart';
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
                    return CategoryItem(categoria: cat);
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

class CategoryItem extends StatelessWidget {
  final Category categoria; 

  const CategoryItem({super.key, required this.categoria});

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'home': return Icons.home;
      case 'directions_car': return Icons.directions_car;
      case 'school': return Icons.school;
      case 'work': return Icons.work;
      case 'entertainment': return Icons.live_tv;
      case 'plane': return Icons.flight;
      case 'shopping_cart': return Icons.shopping_cart;
      case 'restaurant': return Icons.restaurant;
      case 'account_balance_wallet': return Icons.account_balance_wallet;
      case 'fitness_center': return Icons.fitness_center;
      case 'local_hospital': return Icons.local_hospital;
      case 'attach_money': return Icons.attach_money;
      default: return Icons.help_outline;
    }
  }

  void _tentarDeletar(BuildContext context) {
    final historicoNotifier = context.read<HistoricoNotifier>();
    
    final estaEmUso = historicoNotifier.transacoes.any(
      (t) => t.categoryId == categoria.id
    );

    if (estaEmUso) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não é possível excluir. Existem transações usando esta categoria.'),
          backgroundColor: Colors.orange,
        ),
      );
    } else {
      context.read<CategoriaNotifier>().deletarCategoria(categoria.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Categoria apagada com sucesso.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final bool isReceitas = categoria.name == 'Receitas';

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

            child: Icon(
              isReceitas ? Icons.attach_money : _getIconData(categoria.iconName), 
              color: Colors.white, 
              size: 28
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              categoria.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          if (isReceitas)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.lock_outline, color: Colors.grey, size: 24),
            )
          else ...[
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Color(0xFF8B66FF)),
              onPressed: () => _tentarDeletar(context),
            ),
            IconButton(
              icon: const Icon(Icons.edit_outlined, color: Color(0xFFFFC107)),
              onPressed: () {
                context.push('/create-category', extra: categoria); 
              },
            ),
          ],
        ],
      ),
    );
  }
}