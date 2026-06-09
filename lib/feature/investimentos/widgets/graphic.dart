import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invezzte/domain/notifiers/patrimonio_history_notifier.dart';

class Graphic extends StatelessWidget {
  const Graphic({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PatrimonioHistoryNotifier>(
      builder: (context, patrimonioNotifier, _) {
        final historico = patrimonioNotifier.obterUltimos(10);
        
        if (historico.isEmpty) {
          return SizedBox(
            height: 200,
            child: Center(
              child: Text(
                'Adicione investimentos para ver o gráfico',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          );
        }

        final spots = List.generate(
          historico.length,
          (index) => FlSpot(
            index.toDouble(),
            historico[index],
          ),
        );

        return SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: true),
              titlesData: const FlTitlesData(show: true),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  color: const Color(0xFF360B7A),
                  isCurved: true,
                  spots: spots,
                  dotData: const FlDotData(show: true),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

