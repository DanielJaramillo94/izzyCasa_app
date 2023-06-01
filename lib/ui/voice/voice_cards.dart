import 'package:flutter/material.dart';
import 'package:izzy_casa_app/models/light.model.dart';

class VoiceCards extends StatelessWidget {
  const VoiceCards({super.key, required this.light});

  final Light light;

  final String imageOff = "assets/images/home/light-off.png";
  final String imageON = "assets/images/home/light-on.png";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: -10,
            blurRadius: 10,
            offset: const Offset(10, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                light.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.55),
                ),
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset(
                light.state ? imageON : imageOff,
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
