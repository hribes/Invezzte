import 'package:flutter/material.dart';
import 'package:invezzte/feature/widgets/CategorySelector.dart';
import 'package:invezzte/feature/widgets/HeaderScreens.dart';
import 'package:invezzte/feature/widgets/InfoCard.dart';
import 'package:invezzte/feature/widgets/NavBar.dart';
import 'package:provider/provider.dart';
import 'package:invezzte/domain/notifiers/historico_notifier.dart';
import 'package:invezzte/domain/notifiers/categoria_notifier.dart';

class History extends StatefulWidget {
  final String? initialCategoryName;
  const History({super.key, this.initialCategoryName});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _atualizarFiltroPeloParametro();
  }

  @override
  void didUpdateWidget(covariant History oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Se o nome da categoria vinda por parâmetro mudar, atualiza o filtro
    if (oldWidget.initialCategoryName != widget.initialCategoryName) {
      _atualizarFiltroPeloParametro();
    }
  }

  void _atualizarFiltroPeloParametro() {
    if (widget.initialCategoryName != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final categoriaNotifier = context.read<CategoriaNotifier>();
        final index = categoriaNotifier.categorias.indexWhere(
          (c) => c.name == widget.initialCategoryName,
        );

        if (index != -1 && index != _selectedCategoryIndex) {
          setState(() {
            _selectedCategoryIndex = index;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriaNotifier = context.watch<CategoriaNotifier>();
    final historicoNotifier = context.watch<HistoricoNotifier>();

    if (categoriaNotifier.categorias.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final categoriaAtual = categoriaNotifier.categorias[_selectedCategoryIndex];

    final transacoes = historicoNotifier.transacoes
        .where((t) => t.categoryId == categoriaAtual.id)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      bottomNavigationBar: const NavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Headerscreens(title: 'Histórico', firstIcon: Icons.search),
              const SizedBox(height: 30),

              CategorySelector(
                categories: categoriaNotifier.categorias
                    .map((c) => CategoryItem(title: c.name, icon: c.icon))
                    .toList(),
                selectedIndex: _selectedCategoryIndex,
                onCategorySelected: (index) =>
                    setState(() => _selectedCategoryIndex = index),
              ),

              const SizedBox(height: 30),

              Text(
                categoriaAtual.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // LISTA DE TRANSAÇÕES
              ...transacoes.map((t) {
                return InfoCard(
                  title: t.title,
                  date: "${t.date.day}/${t.date.month}/${t.date.year}",
                  icon: categoriaAtual.icon,
                  amount: t.amount,
                  type: t.type,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
