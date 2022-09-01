import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class MyLineChart extends StatelessWidget {
  const MyLineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 300,
      child: LineChart(
        LineChartData(borderData: FlBorderData(show: false), lineBarsData: [
          LineChartBarData(spots: [
            const FlSpot(0, 1),
            const FlSpot(1, 3),
            const FlSpot(2, 10),
            const FlSpot(3, 7),
            const FlSpot(4, 12),
            const FlSpot(5, 13),
            const FlSpot(6, 17),
            const FlSpot(7, 15),
            const FlSpot(8, 20)
          ])
        ]),
      ),
    );
  }
}
