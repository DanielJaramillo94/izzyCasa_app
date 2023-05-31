import 'package:flutter/material.dart';
import 'package:izzy_casa_app/providers/auth.provider.dart';
import 'package:izzy_casa_app/ui/custom_button.dart';
import 'package:izzy_casa_app/ui/home/dynamic_key/dynamic_key_box.dart';
import 'package:izzy_casa_app/ui/home/home_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                children: [
                  const DynamicKeyBox(),
                  const SizedBox(height: 20),
                  const HomeCard(
                    label: 'Temperatura',
                    image: 'assets/images/home/temperature.png',
                    route: '/temperature',
                  ),
                  const SizedBox(height: 20),
                  const HomeCard(
                    label: 'Luces',
                    image: 'assets/images/home/light-on.png',
                    route: '/lights',
                  ),
                  const SizedBox(height: 20),
                  const HomeCard(
                    label: 'Comando de voz',
                    image: 'assets/images/home/microphone.png',
                    route: '/voice',
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'CERRAR SESIÓN',
                    onPressed: () async {
                      var authProvider = Provider.of<AuthProvider>(
                        context,
                        listen: false,
                      );
                      try {
                        authProvider.signOut();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Ha ocurrido al cerrar sesión.'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
