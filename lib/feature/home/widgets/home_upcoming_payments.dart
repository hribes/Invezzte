import 'package:flutter/material.dart';

class HomeUpcomingPayments extends StatefulWidget {
  final List<Map<String, dynamic>>? pagamentos;
  final VoidCallback onVerMaisPressed;
  final Function(String) onPagamentoPressed;

  const HomeUpcomingPayments({
    super.key,
    required this.pagamentos,
    required this.onVerMaisPressed,
    required this.onPagamentoPressed,
  });

  @override
  State<HomeUpcomingPayments> createState() => _HomeUpcomingPaymentsState();
}

class _HomeUpcomingPaymentsState extends State<HomeUpcomingPayments> {
  late List<Map<String, dynamic>> _listaAtual;

  @override
  void initState() {
    super.initState();
    _listaAtual = widget.pagamentos ?? [];
  }

  @override
  void didUpdateWidget(covariant HomeUpcomingPayments oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pagamentos != oldWidget.pagamentos) {
      setState(() {
        _listaAtual = widget.pagamentos ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_listaAtual.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Column(
            children: _listaAtual.map((pagamento) {
              return GestureDetector(
                onTap: () => widget.onPagamentoPressed(pagamento['title']),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xFF9173FF),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          pagamento['icon'],
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pagamento['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              pagamento['date'],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "R\$ ${pagamento['amount'].toStringAsFixed(2).replaceAll('.', ',')}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}