import 'package:flutter/material.dart';
import 'package:izzy_casa_app/models/dynamic_key.dart';
import 'package:izzy_casa_app/providers/dynamic_key.provider.dart';
import 'package:izzy_casa_app/ui/home/dynamic_key/circular_timer/circular_timer.dart';
import 'package:provider/provider.dart';

class DynamicKeyBox extends StatelessWidget {
  const DynamicKeyBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var dynamicKey = context.watch<DynamicKeyProvider>().dynamicKey;
    return Container(
      height: 50,
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.orange,
          width: 3.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              getDynamicKeyCode(dynamicKey),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(child: getCircularTimer(dynamicKey))
          ],
        ),
      ),
    );
  }

  String getDynamicKeyCode(DynamicKey? dynamicKey) {
    if (dynamicKey == null) {
      return '...';
    }
    return dynamicKey.code;
  }

  Widget getCircularTimer(DynamicKey? dynamicKey) {
    if (dynamicKey == null) {
      return const Center(
          child: CircularProgressIndicator(
        color: Colors.orange,
      ));
    }

    return CircularTimer(duration: dynamicKey.remainingTime);
  }
}
