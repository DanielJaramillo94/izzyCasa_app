import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:izzy_casa_app/ui/voice/voice_cards.dart';

class VoiceScreen extends StatefulWidget {
  VoiceScreen({
    super.key,
  });

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  var text = "Presiona el botón y comienza a hablar";
  var isListening = false;
  bool statusPrincipal = false;
  bool statusLivingroom = true;
  SpeechToText speechToText = SpeechToText();

  @override
  Widget build(BuildContext context) {
    String imageOff = "assets/images/home/light-off.png";
    String imageON = "assets/images/home/light-on.png";
    String imagePrincipal = statusPrincipal ? imageON : imageOff;
    String imageLivingroom = statusLivingroom ? imageON : imageOff;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          endRadius: 75.0,
          animate: isListening,
          duration: Duration(milliseconds: 2000),
          glowColor: Colors.orange,
          repeat: true,
          repeatPauseDuration: Duration(milliseconds: 100),
          showTwoGlows: true,
          child: GestureDetector(
            onTapDown: (details) async {
              if (!isListening) {
                var available = await speechToText.initialize();
                if (available) {
                  setState(() {
                    isListening = true;
                    speechToText.listen(onResult: (result) {
                      setState(() {
                        text = result.recognizedWords;
                        if (text == "cocina encender") {
                          print(text);
                        }
                      });
                    });
                  });
                }
              }
            },
            onTapUp: (details) {
              setState(() {
                isListening = false;
              });
              speechToText.stop();
            },
            child: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 35,
              child: Icon(
                isListening ? Icons.mic : Icons.mic_none,
                color: Colors.white,
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text('Comandos por voz'),
        ),
        body: SafeArea(
            child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          margin: const EdgeInsets.only(bottom: 150),
          child: Center(
            child: Column(
              children: [
                VoiceCards(
                  label: 'Principal',
                  image: imagePrincipal,
                ),
                const SizedBox(height: 20),
                VoiceCards(
                  label: 'Sala',
                  image: imageLivingroom,
                ),
                const SizedBox(height: 50),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
