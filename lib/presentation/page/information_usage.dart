import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:reminder_app/model/reminder_model.dart';

class InformationUsage extends StatelessWidget {
  final List<ReminderModelHive?> reminders;
  const InformationUsage({super.key, required this.reminders});

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Incoming": reminders
          .where((element) => element!.date.isAfter(DateTime.now()))
          .toList()
          .length
          .toDouble(),
      "Done": reminders
          .where((element) => element!.date.isBefore(DateTime.now()))
          .toList()
          .length
          .toDouble(),
    };
    return PieChart(
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      colorList: const [Colors.purple, Colors.purpleAccent],
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 32,
      centerText: "Notification Usage",
    );
  }
}