import 'package:flutter/material.dart';

class TemperatureScreen extends StatelessWidget {
  const TemperatureScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperatura'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Temperature screen!'),
        ),
      ),
    );
  }
}
