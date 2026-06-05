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
import 'package:invezzte/domain/category.dart';

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
      context.read<HistoricoNotifier>().inicializarHistorico();
    }
    }); 
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'home': return Icons.home;
      case 'directions_car': return Icons.directions_car;
      case 'shopping_cart': return Icons.shopping_cart;
      case 'restaurant': return Icons.restaurant;
      case 'work': return Icons.work;
      case 'account_balance_wallet': return Icons.account_balance_wallet;
      case 'fitness_center': return Icons.fitness_center;
      case 'local_hospital': return Icons.local_hospital;
      case 'plane': return Icons.flight;
      case 'school': return Icons.school;
      case 'entertainment': return Icons.live_tv;
      default: return Icons.help_outline; 
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).currentUser;
    final saldoNotifier = context.watch<SaldoNotifier>();
    final categoriaNotifier = context.watch<CategoriaNotifier>();

    final categoriasFormatadas = categoriaNotifier.categorias
        .map((cat) => {'icon': _getIconData(cat.iconName), 'label': cat.name})
        .toList();

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
                      saldo: user?.balance ?? 0.0,
                      isSaldoVisivel: _isSaldoVisivel,
                      onToggleSaldo: () =>
                          setState(() => _isSaldoVisivel = !_isSaldoVisivel),
                      onAddPressed: () => context.push('/add-balance'),
                      onNotificationPressed: () =>
                          context.push('/notificacoes'),
                    ),

              const SizedBox(height: 30),

              HomeHistoryCategories(
                categorias: categoriasFormatadas,
                onVerTudoPressed: () => context.push('/history'),
                onCategoriaPressed: (String categoriaNome) {
                  context.push('/history?category=$categoriaNome');
                },
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text("Movimentações recentes", 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 15),
                  Consumer<HistoricoNotifier>(
                  builder: (context, historico, child) {
                    final ultimasMovimentacoes = List.of(historico.transacoes)
                      ..sort((a, b) {
                        final dataCompare = b.date.compareTo(a.date);

                        if (dataCompare != 0) {
                          return dataCompare;
                        }

                        return b.id.compareTo(a.id);
                      });

                    final movimentacoesExibidas =
                        ultimasMovimentacoes.take(5).toList();

                    if (movimentacoesExibidas.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          "Realize alguma movimentação para visualizar",
                          style: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      );
                    }

                    final lista = movimentacoesExibidas.map((t) {
                      final cat = categoriaNotifier.categorias.firstWhere(
                        (c) => c.id == t.categoryId,
                        orElse: () => const Category(
                          id: 0,
                          userId: 0,
                          name: 'Outros',
                          iconName: 'help_outline',
                        ),
                      );

                      return <String, dynamic>{
                        'title': t.title,
                        'date':
                            "${t.date.day.toString().padLeft(2, '0')}/${t.date.month.toString().padLeft(2, '0')}/${t.date.year}",
                        'amount': t.amount,
                        'icon': _getIconData(cat.iconName),
                      };
                    }).toList();

                    return HomeUpcomingPayments(
                      pagamentos: lista,
                      onVerMaisPressed: () => context.push('/history'),
                      onPagamentoPressed: (String titulo) {},
                    );
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