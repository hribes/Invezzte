import 'package:flutter/material.dart' hide SearchBar;
import 'package:go_router/go_router.dart';
import 'package:invezzte/domain/notifiers/user_notifier.dart';
import 'package:provider/provider.dart';
import 'package:invezzte/domain/notifiers/saldo_notifier.dart';
import 'package:invezzte/domain/notifiers/historico_notifier.dart';
import 'package:invezzte/domain/notifiers/categoria_notifier.dart';
import 'package:invezzte/feature/widgets/NavBar.dart';
import 'package:invezzte/feature/home/widgets/home_header_section.dart';
import 'package:invezzte/feature/home/widgets/home_history_categories.dart';
import 'package:invezzte/feature/home/widgets/home_upcoming_payments.dart';

class HomeInvezzte extends StatefulWidget {
  const HomeInvezzte({super.key});

  @override
  State<HomeInvezzte> createState() => _HomeInvezzteState();
}

class _HomeInvezzteState extends State<HomeInvezzte> {
  bool _isSaldoVisivel = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<SaldoNotifier>().carregarSaldo();

        final catNotifier = context.read<CategoriaNotifier>();
        if (catNotifier.categorias.isEmpty) {
          catNotifier.carregarCategoriasMock();
        }

        final histNotifier = context.read<HistoricoNotifier>();
        if (histNotifier.transacoes.isEmpty) {
          histNotifier.carregarDadosMock();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).currentUser;
    final saldoNotifier = context.watch<SaldoNotifier>();
    final categoriaNotifier = context.watch<CategoriaNotifier>();
    final historicoNotifier = context.watch<HistoricoNotifier>();

    // Mapeamento mantendo a estrutura esperada pelo widget HomeHistoryCategories
    final categoriasFormatadas = categoriaNotifier.categorias
        .map((cat) => {'icon': cat.icon, 'label': cat.name})
        .toList();

    final proximosPagamentos = historicoNotifier.transacoes.map((t) {
      return {
        'title': t.title,
        'date': "${t.date.day}/${t.date.month}/${t.date.year}",
        'amount': t.amount,
        'icon': Icons.attach_money,
      };
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              saldoNotifier.carregando
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : HomeHeaderSection(
                      nomeUsuario: user?.name ?? 'Usuário',
                      saldo: user?.saldo ?? 0.0,
                      isSaldoVisivel: _isSaldoVisivel,
                      onToggleSaldo: () =>
                          setState(() => _isSaldoVisivel = !_isSaldoVisivel),
                      onAddPressed: () => context.push('/add-balance'),
                      onNotificationPressed: () =>
                          context.push('/notificacoes'),
                    ),

              const SizedBox(height: 30),

              // Ao clicar, o GoRouter agora envia o nome da categoria como parâmetro de consulta
              HomeHistoryCategories(
                categorias: categoriasFormatadas,
                onVerTudoPressed: () => context.push('/history'),
                onCategoriaPressed: (String categoriaNome) {
                  context.push('/history?category=$categoriaNome');
                },
              ),

              const SizedBox(height: 35),

              HomeUpcomingPayments(
                pagamentos: proximosPagamentos,
                onVerMaisPressed: () => context.push('/history'),
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
