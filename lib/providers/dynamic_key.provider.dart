import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:izzy_casa_app/models/dynamic_key.dart';
import 'package:izzy_casa_app/providers/auth.provider.dart';
import 'package:izzy_casa_app/utils/custom_http_client.dart';
import 'package:izzy_casa_app/utils/locator.dart';

class DynamicKeyProvider extends ChangeNotifier {
  DynamicKey? dynamicKey;

  var httpClient = getIt.get<CustomHttpClient>();

  DynamicKeyProvider(AuthProvider authProvider) {
    getDynamicKey(authProvider);
  }

  Future<void> getDynamicKey(AuthProvider authProvider) async {
    if (!authProvider.isAuthenticated) {
      dynamicKey = null;
      return;
    }
    var response = await httpClient.get('/dynamicKey');
    int millisecondsDelay = 10000;
    if (response != null) {
      var newDynamicKey = DynamicKey.fromJson(jsonDecode(response.body));
      if (newDynamicKey.code != dynamicKey?.code) {
        dynamicKey = newDynamicKey;
        notifyListeners();
        millisecondsDelay = newDynamicKey.remainingTime.inMilliseconds;
      }
    }
    Future.delayed(Duration(seconds: millisecondsDelay ~/ 1000), () {
      getDynamicKey(authProvider);
    });
  }
}
