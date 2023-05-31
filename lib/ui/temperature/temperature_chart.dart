import 'package:flutter/material.dart';
import 'package:izzy_casa_app/models/temperature/temperature.model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TemperatureChart extends StatelessWidget {
  const TemperatureChart(this.data, {super.key});

  final List<Temperature> data;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryYAxis: NumericAxis(
        minimum: 15,
        maximum: 30,
        interval: 5,
      ),
      primaryXAxis: CategoryAxis(
        desiredIntervals: 6,
      ),
      tooltipBehavior: TooltipBehavior(enable: true, format: 'point.y °C'),
      series: <ChartSeries<Temperature, String>>[
        LineSeries<Temperature, String>(
          dataSource: data,
          xValueMapper: (Temperature temperatureData, _) =>
              temperatureData.time,
          yValueMapper: (Temperature temperatureData, _) =>
              temperatureData.measure,
          name: 'Temperatura',
        )
      ],
    );
  }
}
