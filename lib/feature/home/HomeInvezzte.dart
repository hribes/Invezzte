import 'package:flutter/material.dart' hide SearchBar;
import 'package:go_router/go_router.dart'; // Importação do GoRouter
import 'package:invezzte/feature/widgets/NavBar.dart';

import 'package:invezzte/feature/home/widgets/home_header_section.dart';
import 'package:invezzte/feature/home/widgets/home_history_categories.dart';
import 'package:invezzte/feature/home/widgets/home_upcoming_payments.dart';

class Homeinvezzte extends StatefulWidget {
  const Homeinvezzte({super.key});

  @override
  State<Homeinvezzte> createState() => _HomeinvezzteState();
}

class _HomeinvezzteState extends State<Homeinvezzte> {
  final String _nomeUsuario = "Lucas Hygidio";
  final double _saldoTotal = 4569.65;
  
  final List<Map<String, dynamic>> _categoriasHistorico = [
    {'icon': Icons.home_filled, 'label': 'Casa'},
    {'icon': Icons.directions_bus, 'label': 'Transporte'},
    {'icon': Icons.school, 'label': 'Educação'},
    {'icon': Icons.work, 'label': 'Trabalho'},
  ];

  final List<Map<String, dynamic>> _proximosPagamentos = [
    {'title': 'Amazon Prime', 'date': '20 de Março de 2026', 'amount': 30.00, 'icon': Icons.movie_filter_rounded},
    {'title': 'Recarga', 'date': '22 de Março de 2026', 'amount': 45.00, 'icon': Icons.phone_android_rounded},
    {'title': 'Faculdade', 'date': '30 de Março de 2026', 'amount': 900.00, 'icon': Icons.auto_stories_rounded},
  ];

  bool _isSaldoVisivel = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeaderSection(
                nomeUsuario: _nomeUsuario,
                saldo: _saldoTotal,
                isSaldoVisivel: _isSaldoVisivel,
                onToggleSaldo: () => setState(() => _isSaldoVisivel = !_isSaldoVisivel),

                onAddPressed: () => context.push('/add-balance'), 
                onNotificationPressed: () => context.push('/notificacoes'),
              ),
              
              const SizedBox(height: 30),
              
              HomeHistoryCategories(
                categorias: _categoriasHistorico,

                onVerTudoPressed: () => context.push('/history'),
                onCategoriaPressed: (String categoria) {
                  context.push('/historico_categoria/$categoria');
                },
              ),

              const SizedBox(height: 35),

              HomeUpcomingPayments(
                pagamentos: _proximosPagamentos,

                onVerMaisPressed: () => context.push('/pagamentos_agendados'),
                onPagamentoPressed: (String titulo) {
                  context.push('/detalhe_pagamento/$titulo');
                },
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}