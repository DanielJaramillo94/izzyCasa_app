import 'package:flutter/material.dart';
import 'package:izzy_casa_app/providers/temperature.provider.dart';
import 'package:izzy_casa_app/ui/temperature/raw_temperature.dart';
import 'package:izzy_casa_app/ui/temperature/temperature_chart.dart';
import 'package:provider/provider.dart';

class TemperatureScreen extends StatelessWidget {
  const TemperatureScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var temperatures = context.watch<TemperatureProvider>().temperatures;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperatura'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TemperatureChart(temperatures),
              RawTemperatureListData(temperatures),
            ],
          ),
        ),
      ),
    );
  }
}
