import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:izzy_casa_app/models/temperature/temperature.model.dart';
import 'package:izzy_casa_app/utils/custom_http_client.dart';
import 'package:izzy_casa_app/utils/locator.dart';

class TemperatureProvider extends ChangeNotifier {
  List<Temperature> temperatures = [];

  var httpClient = getIt.get<CustomHttpClient>();

  TemperatureProvider() {
    getTemperatures();
  }

  Future<void> getTemperatures() async {
    print('getTemperatures called at ${DateTime.now()}');
    var response = await httpClient.get('http://192.168.1.5:3000/temperature');
    int millisecondsDelay = 5000;
    if (response != null) {
      var rawTemperatures = jsonDecode(response.body) as List;
      temperatures =
          rawTemperatures.map((e) => Temperature.fromJson(e)).toList();
      notifyListeners();
    }
    Future.delayed(Duration(seconds: millisecondsDelay ~/ 1000), () {
      getTemperatures();
    });
  }
}
