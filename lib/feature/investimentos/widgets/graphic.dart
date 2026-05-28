import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Graphic extends StatelessWidget {
  const Graphic({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: true),
          titlesData: const FlTitlesData(show: true),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              color: const Color(0xFFFFD979),
              isCurved: true,
              spots: [
                const FlSpot(0, 1),
                const FlSpot(1, 3),
                const FlSpot(2, 2),
                const FlSpot(3, 5),
                const FlSpot(4, 4),
              ],
            ),
            LineChartBarData(
              color: const Color(0xFF360B7A),
              isCurved: true,
              spots: [
                const FlSpot(0, 1),
                const FlSpot(1, 5),
                const FlSpot(2, 2),
                const FlSpot(3, 4),
                const FlSpot(4, 6),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
