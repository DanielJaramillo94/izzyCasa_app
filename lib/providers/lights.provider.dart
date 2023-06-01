import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:izzy_casa_app/models/light.model.dart';
import 'package:izzy_casa_app/utils/custom_http_client.dart';
import 'package:izzy_casa_app/utils/locator.dart';

class LightsProvider extends ChangeNotifier {
  List<Light> lights = [];

  var httpClient = getIt.get<CustomHttpClient>();

  LightsProvider() {
    getLights();
  }

  Future<void> getLights() async {
    var response = await httpClient.get('/lights');
    if (response != null) {
      var rawLights = jsonDecode(response.body) as List;
      lights = rawLights.map((e) => Light.fromJson(e)).toList();
      notifyListeners();
    }
  }
}
