import 'package:flutter/material.dart';
import 'package:izzy_casa_app/ui/lights/light_cards.dart';

class LightScreen extends StatefulWidget {
  LightScreen({
    super.key,
  });

  @override
  State<LightScreen> createState() => _LightScreenState();
}

class _LightScreenState extends State<LightScreen> {
  bool statusPrincipal = false;
  bool statusLivingroom = false;

  void toggleStatusPrincipal() {
    setState(() {
      statusPrincipal = !statusPrincipal;
    });
  }

  void toggleStatusLivingroom() {
    setState(() {
      statusLivingroom = !statusLivingroom;
    });
  }

  @override
  Widget build(BuildContext context) {
    String imageOff = "assets/images/home/swich-off.png";
    String imageON = "assets/images/home/swich-on.png";
    String imagePrincipal = statusPrincipal ? imageON : imageOff;
    String imageLivingroom = statusLivingroom ? imageON : imageOff;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Luces'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                LightCards(
                  label: 'Principal',
                  image: imagePrincipal,
                  onTap: toggleStatusPrincipal,
                ),
                const SizedBox(height: 20),
                LightCards(
                  label: 'Sala',
                  image: imageLivingroom,
                  onTap: toggleStatusLivingroom,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
