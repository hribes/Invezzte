import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 
import 'package:invezzte/features/investimento/presentation/investment.dart';
import 'package:invezzte/features/gastos/presentation/spending.dart';
import 'package:invezzte/features/autenticacao/presentation/screens/HomeInvezzte.dart';

// Configuração das rotas
final GoRouter _router = GoRouter(
  initialLocation: '/home', 
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const Homeinvezzte(),
    ),
    GoRoute(
      path: '/spending',
      builder: (context, state) => const Spending(),
    ),
    GoRoute(
      path: '/investment',
      builder: (context, state) => const Investment(),
    ),
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