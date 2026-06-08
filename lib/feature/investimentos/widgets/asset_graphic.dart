import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:invezzte/domain/notifiers/investimento_notifier.dart';

class AssetGraphic extends StatelessWidget {
  final int assetId;
  final String assetName;

  const AssetGraphic({
    super.key,
    required this.assetId,
    required this.assetName,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<InvestimentoNotifier>(
      builder: (context, notifier, child) {
        final spots = _gerarSpotsAtivo(notifier);

        if (spots.isEmpty) {
          return const SizedBox(height: 150);
        }

        final maxValue = spots.map((e) => e.y).reduce((a, b) => a > b ? a : b);
        final minValue = spots.map((e) => e.y).reduce((a, b) => a < b ? a : b);
        final range = maxValue - minValue;
        final padding = range * 0.2;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Evolução - $assetName',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF360B7A),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 150,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: true, drawHorizontalLine: true),
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
                                style: const TextStyle(fontSize: 9),
                              );
                            }
                            return const SizedBox();
                          },
                          reservedSize: 30,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              'R\$ ${(value / 1000).toStringAsFixed(0)}k',
                              style: const TextStyle(fontSize: 9),
                            );
                          },
                          reservedSize: 45,
                        ),
                      ),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.grey[300]!, width: 1),
                    ),
                    minY: (minValue - padding).clamp(0, double.infinity),
                    maxY: maxValue + padding,
                    lineBarsData: [
                      LineChartBarData(
                        color: const Color(0xFFFFD979),
                        isCurved: true,
                        spots: spots,
                        dotData: const FlDotData(show: true),
                        belowBarData: BarAreaData(
                          show: true,
                          color: const Color(0xFFFFD979).withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<FlSpot> _gerarSpotsAtivo(InvestimentoNotifier notifier) {
    final operacoes = notifier.obterOperacoesDoAtivo(assetId);

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
