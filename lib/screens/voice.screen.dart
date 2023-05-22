import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:izzy_casa_app/ui/lights/light_cards.dart';
import 'package:speech_to_text/speech_to_text.dart';

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
  SpeechToText speechToText = SpeechToText();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          endRadius: 75.0,
          animate: isListening,
          duration: Duration(milliseconds: 2000),
          glowColor: Colors.blueGrey,
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
              backgroundColor: Colors.blueGrey,
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
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          margin: const EdgeInsets.only(bottom: 150),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
          ),
        ));
  }
}
