import 'package:flutter/material.dart';
import 'package:invezzte/feature/widgets/CategorySelector.dart';
import 'package:invezzte/feature/widgets/HeaderScreens.dart';
import 'package:invezzte/feature/widgets/InfoCard.dart';
import 'package:invezzte/feature/widgets/NavBar.dart';


class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  int _selectedCategoryIndex = 0;
  final List<CategoryItem> _categories = [
    CategoryItem(title: "Casa", icon: Icons.home),
    CategoryItem(title: "Transporte", icon: Icons.directions_bus),
    CategoryItem(title: "Educação", icon: Icons.school),
    CategoryItem(title: "Trabalho", icon: Icons.work),
  ];

  @override
  Widget build(BuildContext context) {

    String currentCategoryName = _categories[_selectedCategoryIndex].title;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), 
      bottomNavigationBar: const NavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Headerscreens(
                title: 'Histórico',
                firstIcon: Icons.search,
              ),
              const SizedBox(height: 30),
              CategorySelector(
                categories: _categories,
                selectedIndex: _selectedCategoryIndex,
                onCategorySelected: (index) {
              
                  setState(() {
                    _selectedCategoryIndex = index;
                  });
                },
              ),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    currentCategoryName, 
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        "01/01/2026",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.calendar_month,
                        color: const Color(0xFFFFB300), // Amarelo/laranja
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              InfoCard(
                title: 'Amazon Prime',
                date: '20 de Março de 2026',
                icon: Icons.movie_creation,
                amount: 30.00,
                type: TransactionType.saida,
              ),
              InfoCard(
                title: 'Recarga',
                date: '22 de Março de 2026',
                icon: Icons.phone_android,
                amount: 45.00,
                type: TransactionType.saida,
              ),
              InfoCard(
                title: 'Venda da bicicleta',
                date: '30 de Março de 2026',
                icon: Icons.add,
                amount: 1300.00,
                type: TransactionType.entrada,
              ),
              InfoCard(
                title: 'Faculdade',
                date: '30 de Março de 2026',
                icon: Icons.school,
                amount: 900.00,
                type: TransactionType.saida,
              ),
              
              const SizedBox(height: 20), 
            ],
          ),
        ),
      ),
    );
  }
}