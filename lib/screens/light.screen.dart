import 'package:flutter/material.dart';
import 'package:izzy_casa_app/extensions/iterable_insert_between.dart';
import 'package:izzy_casa_app/ui/lights/light_card.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Luces'),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: LightsList(
              lights: [
                Light(
                  id: 'room0',
                  label: 'Cuarto principal',
                  initialState: true,
                ),
                Light(
                  id: 'room1',
                  label: 'Cuarto Pepito',
                  initialState: false,
                ),
                Light(
                  id: 'room2',
                  label: 'Cuarto Fulanita',
                  initialState: false,
                ),
              ],
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

class Light {
  const Light({
    required this.id,
    required this.label,
    required this.initialState,
  });

  final String id;
  final String label;
  final bool initialState;
}
