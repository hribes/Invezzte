import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invezzte/feature/widgets/OptionSheet.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/spending')) return 1;
    if (location.startsWith('/investment')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  // Mantemos a mesma lógica de navegação
  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0: context.go('/home'); break;
      case 1: context.go('/spending'); break;
      case 2: _showAddOptions(context); // Chama o modal aqui!
       break;
      case 3: context.go('/investment'); break;
      case 4: context.go('/profile'); break;
    }
  }

  void _showAddOptions(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4), // Cor do fundo escurecido
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 110.0, left: 20, right: 20),
            child: Material(
              color: Colors.transparent,
              child: const AddOptionsSheet(), // Chama o seu widget aqui
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final int currentIndex = _calculateSelectedIndex(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        
        height: 75,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
  
            _buildNavItem(context, icon: Icons.home_outlined, index: 0, currentIndex: currentIndex),
            _buildNavItem(context, icon: Icons.account_balance_wallet_outlined, index: 1, currentIndex: currentIndex),
            _buildCenterAddButton(context),
            _buildNavItem(context, icon: Icons.bar_chart_outlined, index: 3, currentIndex: currentIndex),
            _buildNavItem(context, icon: Icons.person_outlined, index: 4, currentIndex: currentIndex),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, {required IconData icon, required int index, required int currentIndex}) {
    final isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () => _onItemTapped(index, context),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(12),
        // O Ícone
        child: Icon(
          icon,
          size: 32,
          color: isSelected ? const Color(0xFFFFD583) : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildCenterAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _onItemTapped(2, context),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(12),
        child: const Icon(
          Icons.add_circle,
          size: 32,
          color: Color(0xFF8F64FF),
        ),
      ),
    );
  }
}