import 'package:flutter/material.dart';
import 'package:izzy_casa_app/screens/light.screen.dart';
import 'package:izzy_casa_app/utils/custom_http_client.dart';
import 'package:izzy_casa_app/utils/locator.dart';

class LightCard extends StatefulWidget {
  const LightCard({
    super.key,
    required this.light,
  });

  final Light light;

  final String imageOff = "assets/images/home/swich-off.png";
  final String imageON = "assets/images/home/swich-on.png";

  @override
  State<LightCard> createState() => _LightCardState();
}

class _LightCardState extends State<LightCard> {
  late bool lightState;
  @override
  void initState() {
    super.initState();
    lightState = widget.light.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        changeState();
        var httpClient = getIt.get<CustomHttpClient>();
        var response = await httpClient.post(
          context,
          'https://69f2-2800-e2-7b7f-f3f5-ff33-4ad0-318d-7e34.ngrok.io/lights/${widget.light.id}?status=${lightState ? 'true' : 'false'}',
          showLoader: false,
        );
        if (response == null) {
          changeState();
        }
      },
      child: Container(
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
                  widget.light.label,
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
                  lightState ? widget.imageON : widget.imageOff,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeState() {
    setState(() {
      lightState = !lightState;
    });
  }
}
