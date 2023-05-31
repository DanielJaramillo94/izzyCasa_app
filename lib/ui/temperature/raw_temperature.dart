import 'package:flutter/material.dart';
import 'package:izzy_casa_app/models/temperature/temperature.model.dart';

class RawTemperatureListData extends StatelessWidget {
  const RawTemperatureListData(this.data, {super.key});

  final List<Temperature> data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            color: Colors.orange.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                const Text(
                  'Hora',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Temperatura',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueAccent.shade400,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Text(
                      data[index].time,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${data[index].measure}°C',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueAccent.shade400,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
