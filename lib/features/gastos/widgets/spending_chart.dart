import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SpendingChart extends StatelessWidget {
  const SpendingChart({super.key});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 180,
      width: 180,
      child: Stack( 
        children: [
          Positioned.fill(
            child: PieChart(
              PieChartData(
                startDegreeOffset: -90,
                centerSpaceRadius: 70,
                sectionsSpace: 0,
                sections: [
                  _buildPieSection(value: 35, color: const Color(0xFF2A1C6A)),
                  _buildPieSection(value: 30, color: const Color(0xFF6B4EEA)),
                  _buildPieSection(value: 20, color: const Color(0xFF9181F4)),
                  _buildPieSection(value: 15, color: const Color(0xFFC0A6F4)),
                ],
              ),
            ),
          ),
          

          const Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'R\$2.482,00',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, 
                  ),
                ),
                Text(
                  'Seus gastos',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static PieChartSectionData _buildPieSection({
    required double value,
    required Color color,
  }) {
    return PieChartSectionData(
      color: color,
      value: value,
      title: '',
      radius: 30,
    );
  }
}