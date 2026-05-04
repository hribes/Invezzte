import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/spending')) return 1;
    if (location.startsWith('/investment')) return 3;
    // if (location.startsWith('/add')) return 2;
    // if (location.startsWith('/charts')) return 3;
    // if (location.startsWith('/profile')) return 4;
    
    return 0; // Padrão
  }



  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/spending');
        break;
      case 2:
        
        // context.go('/add');
        break;
      case 3:
        context.go('/investment');
        // context.go('/charts');
        break;
      case 4:
        // context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          selectedItemColor: const Color(0xFFFFD583),
          unselectedItemColor: Colors.grey,
          currentIndex: _calculateSelectedIndex(context),
          onTap: (int index) => _onItemTapped(index, context), 
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 28),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined, size: 28),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle, size: 28, color: Color(0xFF8F64FF)),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined, size: 28),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined, size: 28),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}