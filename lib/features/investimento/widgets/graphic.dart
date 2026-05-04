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
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(show: true),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              color: Color(0xFFFFD979),
              isCurved: true,
              spots: [
                FlSpot(0, 1),
                FlSpot(1, 3),
                FlSpot(2, 2),
                FlSpot(3, 5),
                FlSpot(4, 4),
              ],
            ),
            LineChartBarData(
              color: Color(0xFF360B7A),
              isCurved: true,
              spots: [
                FlSpot(0, 1),
                FlSpot(1, 5),
                FlSpot(2, 2),
                FlSpot(3, 4),
                FlSpot(4, 6),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
