import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:invezzte/core/injecao.dart';
import 'package:invezzte/domain/notifiers/saldo_notifier.dart';
import 'package:invezzte/feature/cadastros/AddBalance.dart';
import 'package:invezzte/feature/cadastros/AddExpense.dart';
import 'package:invezzte/feature/configuracao/ProfileConfiguration.dart';
import 'package:invezzte/feature/historico/History.dart';
import 'package:invezzte/feature/investimentos/investment.dart';
import 'package:invezzte/feature/gastos/spending.dart';
import 'package:invezzte/feature/home/HomeInvezzte.dart';
import 'package:invezzte/feature/login/Login.dart';
import 'package:invezzte/feature/configuracao/CategoryCreate.dart';
import 'package:invezzte/feature/cadastros/RegisterUser.dart';
import 'package:invezzte/feature/configuracao/Category.dart';

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
    GoRoute(path: '/create-category', builder: (context, state) => CategoryCreate()),
    GoRoute(path: '/register-user', builder: (context, state) => const RegisterUser()),
    GoRoute(path: '/history', builder: (context, state) => const History()),
    GoRoute(path: '/category', builder: (context, state) => const Categories()),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configurarDependencias();
  runApp(const InvezzteApp());
}

class InvezzteApp extends StatelessWidget {
  const InvezzteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<SaldoNotifier>(),
      child: MaterialApp.router(
        title: 'Invezzte',
        theme: ThemeData(fontFamily: 'Poppins', primarySwatch: Colors.blue),
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}