import 'package:flutter/material.dart';
import 'package:invezzte/features/investimento/presentation/investment.dart';

void main() {
  runApp(const InvezzteApp());
}

class InvezzteApp extends StatelessWidget {
  const InvezzteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invezzte',
      theme: ThemeData(fontFamily: 'Poppins', primarySwatch: Colors.blue),
      home: const Investment(),
      debugShowCheckedModeBanner: false,
    );
  }
}
