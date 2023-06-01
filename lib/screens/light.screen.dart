import 'package:flutter/material.dart';
import 'package:izzy_casa_app/extensions/iterable_insert_between.dart';
import 'package:izzy_casa_app/models/light.model.dart';
import 'package:izzy_casa_app/providers/lights.provider.dart';
import 'package:izzy_casa_app/ui/lights/light_card.dart';
import 'package:provider/provider.dart';

class LightScreen extends StatefulWidget {
  const LightScreen({
    super.key,
  });

  @override
  State<LightScreen> createState() => _LightScreenState();
}

class _LightScreenState extends State<LightScreen> {
  bool statusPrincipal = false;
  bool statusLivingroom = false;

  @override
  Widget build(BuildContext context) {
    var lights = context.watch<LightsProvider>().lights;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Luces'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: LightsList(lights: lights),
            ),
          ),
        ),
      ),
    );
  }
}

class LightsList extends StatelessWidget {
  const LightsList({
    super.key,
    required this.lights,
  });

  final List<Light> lights;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: lights
          .map<Widget>((light) => LightCard(light: light))
          .insertBetween(const SizedBox(height: 30))
          .toList(),
    );
  }
}
