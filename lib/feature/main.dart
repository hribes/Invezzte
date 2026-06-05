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
import 'package:invezzte/domain/notifiers/user_notifier.dart';
import 'package:invezzte/domain/notifiers/historico_notifier.dart';
import 'package:invezzte/domain/notifiers/categoria_notifier.dart';
import 'package:invezzte/domain/suporte/database_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:invezzte/domain/notifiers/investimento_notifier.dart';
import 'package:invezzte/feature/configuracao/ProfileUser.dart'; 
import 'package:invezzte/domain/category.dart';
import 'dart:io' show Platform;



final GoRouter _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const Login()),
    GoRoute(path: '/home', builder: (context, state) => const HomeInvezzte()),
    GoRoute(path: '/spending', builder: (context, state) => const Spending()),
    GoRoute(
      path: '/investment',
      builder: (context, state) => const Investment(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileConfiguration(),
    ),
    GoRoute(
      path: '/add-expense',
      builder: (context, state) => const AddExpense(),
    ),
    GoRoute(
      path: '/add-balance',
      builder: (context, state) => const AddBalance(),
    ),
    GoRoute(
      path: '/create-category',
      builder: (context, state) {

      final category = state.extra as Category?;
      return CategoryCreate(categoriaParaEditar: category);
  },
    ),
    GoRoute(
      path: '/register-user',
      builder: (context, state) => const RegisterUser(),
    ),
    GoRoute(
      path: '/history',
      builder: (context, state) {
        final categoryName = state.uri.queryParameters['category'];
        return History(initialCategoryName: categoryName);
      },
    ),
    GoRoute(path: '/category', builder: (context, state) => const Categories()),
    GoRoute(path: '/profile-user', builder: (context, state) => const ProfileUser()),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  await setupInjecao();
  await sl<DatabaseHelper>().database;

  runApp(const InvezzteApp());
}

class InvezzteApp extends StatelessWidget {
  const InvezzteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<SaldoNotifier>()),
        ChangeNotifierProvider(create: (_) => sl<UserProvider>()),
        ChangeNotifierProvider(create: (_) => sl<HistoricoNotifier>()),
        ChangeNotifierProvider(create: (_) => sl<CategoriaNotifier>()),
        ChangeNotifierProvider(create: (_) => sl<InvestimentoNotifier>()),
      ],
      child: MaterialApp.router(
        title: 'Invezzte',
        theme: ThemeData(fontFamily: 'Poppins', primarySwatch: Colors.blue),
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
