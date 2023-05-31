import 'package:flutter/material.dart';
import 'package:izzy_casa_app/ui/home/dynamic_key/circular_timer/circular_timer.dart';

class DynamicKeyBox extends StatelessWidget {
  const DynamicKeyBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              '362566',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
            ),
            SizedBox(width: 20),
            Expanded(child: CircularTimer())
          ],
        ),
      ),
    );
  }
}
