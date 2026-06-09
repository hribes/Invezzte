import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SellModal extends StatefulWidget {
  final String ticker;
  final double quantidadeDisponivel;
  final Function(double quantidadeVenda, double valorVenda) onConfirm;

  const SellModal({
    super.key,
    required this.ticker,
    required this.quantidadeDisponivel,
    required this.onConfirm,
  });

  @override
  State<SellModal> createState() => _SellModalState();
}

class _SellModalState extends State<SellModal> {
  final TextEditingController quantidadeController = TextEditingController();
  bool isLoading = false;
  double precoAtual = 0;
  double valorTotal = 0;

  @override
  void initState() {
    super.initState();
    quantidadeController.addListener(_calcularValor);
    _buscarPrecoAtual();
  }

  Future<void> _buscarPrecoAtual() async {
    try {
      final url = Uri.parse(
        'https://brapi.dev/api/quote/${widget.ticker}?token=kAVfyCqeHFkgMGmQQ4PUQ1',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          precoAtual = data['results'][0]['regularMarketPrice'] as double;
        });
        _calcularValor();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao buscar cotação: $e')),
        );
      }
    }
  }

  void _calcularValor() {
    final quantidade = double.tryParse(quantidadeController.text) ?? 0;
    setState(() {
      valorTotal = quantidade * precoAtual;
    });
  }

  void _confirmarVenda() {
    final quantidade = double.tryParse(quantidadeController.text);

    if (quantidade == null || quantidade <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insira uma quantidade válida.')),
      );
      return;
    }

    if (quantidade > widget.quantidadeDisponivel) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Quantidade indisponível. Máximo: ${widget.quantidadeDisponivel.toInt()} cotas',
          ),
        ),
      );
      return;
    }

    widget.onConfirm(quantidade, valorTotal);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    quantidadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Vender Ações',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Ativo: ${widget.ticker}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Text(
              'Disponível: ${widget.quantidadeDisponivel.toInt()} cotas',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 15),
            if (precoAtual > 0)
              Text(
                'Preço atual: R\$ ${precoAtual.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF360B7A),
                ),
              ),
            const SizedBox(height: 20),
            TextField(
              controller: quantidadeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantidade para vender',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.sell),
              ),
            ),
            const SizedBox(height: 15),
            if (valorTotal > 0)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E0F8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Valor total:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'R\$ ${valorTotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF360B7A),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[400],
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B6B),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: _confirmarVenda,
                    child: const Text(
                      'Confirmar Venda',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
