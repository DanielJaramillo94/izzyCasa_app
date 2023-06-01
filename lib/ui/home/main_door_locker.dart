import 'package:flutter/material.dart';
import 'package:izzy_casa_app/utils/custom_http_client.dart';
import 'package:izzy_casa_app/utils/locator.dart';

class MainDoorLocker extends StatelessWidget {
  const MainDoorLocker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await getIt.get<CustomHttpClient>().post('/lockMainDoor');
      },
      child: Icon(
        Icons.screen_lock_portrait_outlined,
        color: Colors.grey.shade600,
        size: 45,
      ),
    );
  }
}
