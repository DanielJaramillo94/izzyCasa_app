import 'package:flutter/material.dart';
import 'package:izzy_casa_app/models/temperature/temperature.model.dart';
import 'package:izzy_casa_app/ui/temperature/raw_temperature.dart';
import 'package:izzy_casa_app/ui/temperature/temperature_chart.dart';

class TemperatureScreen extends StatelessWidget {
  TemperatureScreen({
    super.key,
  });

  final List<Temperature> data = [
    Temperature('8:00', 23),
    Temperature('8:10', 24),
    Temperature('8:20', 25),
    Temperature('8:30', 26),
    Temperature('8:40', 26),
    Temperature('8:50', 26),
    Temperature('9:00', 26),
    Temperature('9:10', 27),
    Temperature('9:20', 29),
    Temperature('9:30', 28),
    Temperature('9:40', 26),
    Temperature('9:50', 24),
    Temperature('10:00', 22),
    Temperature('10:10', 20),
    Temperature('10:20', 20),
    Temperature('10:30', 20),
    Temperature('10:40', 21),
    Temperature('10:50', 22),
    Temperature('11:00', 22),
    Temperature('11:10', 23)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperatura'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TemperatureChart(data),
              RawTemperatureListData(data),
            ],
          ),
        ),
      ),
    );
  }
}
