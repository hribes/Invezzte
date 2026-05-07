import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invezzte/feature/cadastros/AddBalance.dart';
import 'package:invezzte/feature/cadastros/AddExpense.dart';
import 'package:invezzte/feature/configuracao/ProfileConfiguration.dart';
import 'package:invezzte/feature/investimentos/investment.dart';
import 'package:invezzte/feature/gastos/spending.dart';
import 'package:invezzte/feature/home/HomeInvezzte.dart';
import 'package:invezzte/feature/login/Login.dart';

// Configuração das rotas
final GoRouter _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const Login()),    
    GoRoute(path: '/home', builder: (context, state) => const Homeinvezzte()),
    GoRoute(path: '/spending', builder: (context, state) => const Spending()),
    GoRoute(path: '/investment', builder: (context, state) => const Investment()),
    GoRoute(path: '/profile', builder: (context, state) => const ProfileConfiguration()),
    GoRoute(path: '/add-expense', builder: (context, state) => const AddExpense()),
    GoRoute(path: '/add-balance', builder: (context, state) => const AddBalance()),
  ],
);

void main() {
  runApp(const InvezzteApp());
}

class InvezzteApp extends StatelessWidget {
  const InvezzteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Invezzte',
      theme: ThemeData(fontFamily: 'Poppins', primarySwatch: Colors.blue),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
