import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:izzy_casa_app/extensions/iterable_insert_between.dart';
import 'package:izzy_casa_app/models/light.model.dart';
import 'package:izzy_casa_app/providers/lights.provider.dart';
import 'package:izzy_casa_app/utils/custom_http_client.dart';
import 'package:izzy_casa_app/utils/locator.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:izzy_casa_app/ui/voice/voice_cards.dart';

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({
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
    var lights = context.watch<LightsProvider>().lights;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 75.0,
        animate: isListening,
        duration: const Duration(milliseconds: 2000),
        glowColor: Colors.orange,
        repeat: true,
        repeatPauseDuration: const Duration(milliseconds: 100),
        showTwoGlows: true,
        child: GestureDetector(
          onTapDown: (details) async {
            if (!isListening) {
              var available = await speechToText.initialize();
              if (available) {
                setState(() {
                  isListening = true;
                  speechToText.listen(onResult: (result) async {
                    setState(() {
                      text = result.recognizedWords;
                    });
                    setLightState(lights);
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
        title: const Text('Comando de voz'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                children: [
                  ...lights
                      .map<Widget>((light) => VoiceCards(light: light))
                      .insertBetween(const SizedBox(height: 30))
                      .toList(),
                  const SizedBox(height: 50),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 150),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setLightState(List<Light> lights) {
    (String, bool)? commandedLight = changeLightStateByText(
      text,
      lights.map((light) => light.label).toList(),
    );
    print(commandedLight);
    if (commandedLight == null) {
      return;
    }
    var httpClient = getIt.get<CustomHttpClient>();
    String? location = labelToLocation(commandedLight.$1, lights);
    if (location == null) {
      return;
    }
    httpClient.post(
      '/lights/$location',
      queryParameters: {'status': commandedLight.$2 ? 'true' : 'false'},
    );
  }

  String? labelToLocation(String label, List<Light> lights) {
    for (Light light in lights) {
      if (light.label == label) {
        return light.location;
      }
    }
    return null;
  }

  (String label, bool state)? changeLightStateByText(
    String text,
    List<String> locations,
  ) {
    List<String> onKeywords = ['encender', 'prender', 'activar'];
    List<String> offKeywords = ['apagar', 'apaga', 'desactivar'];

    String? location;
    for (String name in locations) {
      if (text.toLowerCase().contains(name.toLowerCase())) {
        location = name;
        break;
      }
    }

    if (location == null) {
      return null;
    }

    bool? state;
    for (String keyword in onKeywords) {
      if (text.toLowerCase().contains(keyword.toLowerCase())) {
        state = true;
        break;
      }
    }
    for (String keyword in offKeywords) {
      if (text.toLowerCase().contains(keyword.toLowerCase())) {
        state = false;
        break;
      }
    }

    if (state == null) {
      return null;
    }

    return (location, state);
  }
}
