import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SpendingChart extends StatelessWidget {
  final double total;
  final List<Map<String, dynamic>> transactions;

  const SpendingChart({
    super.key,
    required this.total,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    // Formatação monetária básica para o texto central
    String displayTotal = 'R\$${total.toStringAsFixed(2).replaceAll('.', ',')}';

    return SizedBox(
      height: 180,
      width: 180,
      child: Stack(
        children: [
          Positioned.fill(
            child: PieChart(
              PieChartData(
                startDegreeOffset: -90,
                centerSpaceRadius: 65,
                sectionsSpace: 0,
                // Função que converte as transações em fatias do gráfico
                sections: _generateSections(),
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  displayTotal,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Seus gastos',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Gera dinamicamente as fatias. Se o filtro estiver vazio, exibe um anel cinza.
  List<PieChartSectionData> _generateSections() {
    if (transactions.isEmpty || total == 0) {
      return [_buildPieSection(value: 100, color: Colors.black12)];
    }

    // Paleta de roxos para distribuir entre os itens
    List<Color> colors = [
      const Color(0xFF2A1C6A),
      const Color(0xFF6B4EEA),
      const Color(0xFF9181F4),
      const Color(0xFFC0A6F4),
    ];

    return List.generate(transactions.length, (index) {
      final item = transactions[index];
      // Pega a cor baseada no index, reciclando se houver mais itens que cores
      final color = colors[index % colors.length]; 
      
      return _buildPieSection(
        value: item['amount'], // O fl_chart calcula a % sozinho baseado nos valores passados
        color: color,
      );
    });
  }

  static PieChartSectionData _buildPieSection({
    required double value,
    required Color color,
  }) {
    return PieChartSectionData(
      color: color,
      value: value,
      title: '',
      radius: 18,
    );
  }
}