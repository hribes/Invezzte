import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:invezzte/domain/notifiers/investimento_notifier.dart';

class Graphic extends StatelessWidget {
  const Graphic({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InvestimentoNotifier>(
      builder: (context, notifier, child) {
        final spots = _gerarSpotsPatrimonio(notifier);
        
        if (spots.isEmpty) {
          return SizedBox(
            height: 200,
            child: Center(
              child: Text(
                'Nenhum investimento ainda',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        }

        return SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: true),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (spots.isEmpty) return const SizedBox();
                      final index = value.toInt();
                      if (index >= 0 && index < spots.length) {
                        final date = DateTime.fromMillisecondsSinceEpoch(
                          spots[index].x.toInt() * 1000,
                        );
                        return Text(
                          DateFormat('dd/MM').format(date),
                          style: const TextStyle(fontSize: 10),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        'R\$ ${(value / 1000).toStringAsFixed(0)}k',
                        style: const TextStyle(fontSize: 10),
                      );
                    },
                  ),
                ),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  color: const Color(0xFF360B7A),
                  isCurved: true,
                  spots: spots,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(
                    show: true,
                    color: const Color(0xFF360B7A).withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<FlSpot> _gerarSpotsPatrimonio(InvestimentoNotifier notifier) {
    final operacoes = notifier.operacoes;
    
    if (operacoes.isEmpty) return [];

    operacoes.sort((a, b) => a.date.compareTo(b.date));

    final spots = <FlSpot>[];
    double acumulado = 0;

    for (int i = 0; i < operacoes.length; i++) {
      acumulado += operacoes[i].totalAmount;
      spots.add(
        FlSpot(
          operacoes[i].date.millisecondsSinceEpoch / 1000,
          acumulado,
        ),
      );
    }

    return spots;
  }
}
