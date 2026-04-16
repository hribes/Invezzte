import 'package:flutter/material.dart';
import 'package:invezzte/features/autenticacao/presentation/screens/HomeInvezzte.dart';

void main() {
  runApp(const InvezzteApp());
}

class InvezzteApp extends StatelessWidget {
  const InvezzteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invezzte',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Homeinvezzte(),
      debugShowCheckedModeBanner: false,
    );
  }
}
