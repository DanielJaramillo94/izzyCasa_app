import 'dart:convert';

import 'package:http/http.dart';
import 'package:izzy_casa_app/models/system/request_inconsistency.dart';

extension HttpStatusResponseExtension on Response {
  bool is2xxSuccessful() {
    return statusCode >= 200 && statusCode < 300;
  }

  bool is4xxClientError() {
    return statusCode >= 400 && statusCode < 500;
  }

  bool is5xxServerError() {
    return statusCode >= 500 && statusCode < 600;
  }
}

extension Http4xxResponseExtension on Response {
  String get4xxErrorMessage() {
    String errorMessage;
    try {
      var responseBody = json.decode(body);
      if (responseBody is Map) {
        return 'Parece que tenemos dificultades en la app 😥.';
      }
      List<RequestInconsistency> inconsistencies = (json.decode(body) as List)
          .map<RequestInconsistency>(
              (data) => RequestInconsistency.fromJson(data))
          .toList();
      errorMessage = inconsistencies.first.message;
    } catch (e) {
      errorMessage = 'No pudimos realizar esta acción 😥.';
    }
    return errorMessage;
  }
}
