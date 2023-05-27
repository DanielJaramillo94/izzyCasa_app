import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:izzy_casa_app/extensions/http_response.extension.dart';
import 'package:izzy_casa_app/extensions/loader.extension.dart';
import 'package:izzy_casa_app/models/system/snackbar_message.dart';
import 'dart:developer';

class CustomHttpClient {
  final List<StreamSink<SnackBarMessage?>> errorStreamSinks = [];
  CustomHttpClient();

  Future<String?> get userAccessToken async {
    return FirebaseAuth.instance.currentUser?.getIdToken();
  }

  launchError(String errorMessage) {
    for (var errorSink in errorStreamSinks) {
      errorSink.add(SnackBarMessage(errorMessage));
    }
  }

  void addErrorStreamSink(StreamSink<SnackBarMessage?> sink) {
    errorStreamSinks.add(sink);
  }

  Future<Map<String, String>?> getHeaders() async {
    var headers = {'Content-Type': 'application/json'};
    var token = await userAccessToken;
    if (token != null) {
      headers.putIfAbsent('Authorization', () => 'Bearer $token');
      log(token);
    }
    return headers;
  }

  SuccessfulResponse? processResponse(http.Response response) {
    if (response.is2xxSuccessful()) {
      return SuccessfulResponse(response.body, response.statusCode);
    } else if (response.is4xxClientError()) {
      String backErrorMessage = response.get4xxErrorMessage();
      launchError(backErrorMessage);
      return null;
    } else if (response.is5xxServerError()) {
      launchError(
          'Tenemos un fallo en el servidor, estamos trabajando para resolverlo 🔧⚡');
      return null;
    } else {
      launchError('Tenemos problemas para comunicarnos con el servidor. 📞');
      return null;
    }
  }

  void launchConnectionError() {
    launchError(
      'No pudimos comunicarnos con el servidor. 😥\nRevisa tu conexión a internet.',
    );
  }

  Future<SuccessfulResponse?> get(
    BuildContext context,
    String url,
  ) async {
    Uri uri = Uri.parse(url);
    http.Response? response;
    context.showLoader();
    try {
      response = await http.get(
        uri,
        headers: await getHeaders(),
      );
    } catch (e) {
      launchConnectionError();
      return null;
    } finally {
      context.hideLoader();
    }
    return processResponse(response);
  }

  Future<SuccessfulResponse?> post(
    BuildContext context,
    String url, [
    Map<String, dynamic>? body,
  ]) async {
    Uri uri = Uri.parse(url);
    http.Response? response;
    context.showLoader();
    try {
      response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: await getHeaders(),
      );
    } catch (e) {
      launchConnectionError();
      return null;
    } finally {
      context.hideLoader();
    }
    return processResponse(response);
  }

  Future<SuccessfulResponse?> delete(
    BuildContext context,
    String url, [
    Map<String, dynamic>? body,
  ]) async {
    Uri uri = Uri.parse(url);
    http.Response? response;
    context.showLoader();
    try {
      response = await http.delete(
        uri,
        body: jsonEncode(body),
        headers: await getHeaders(),
      );
    } catch (e) {
      launchConnectionError();
      return null;
    } finally {
      context.hideLoader();
    }
    return processResponse(response);
  }

  Future<SuccessfulResponse?> postMultipart(
    BuildContext context,
    String url,
    Map<String, String> fields,
    List<http.MultipartFile> filesToUpload,
  ) async {
    Uri uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(await getHeaders() ?? {});
    request.fields.addAll(fields);
    request.files.addAll(filesToUpload);
    http.Response? response;
    if (context.mounted) {
      context.showLoader();
    }
    try {
      response = await http.Response.fromStream(await request.send());
    } catch (e) {
      launchConnectionError();
      return null;
    } finally {
      if (context.mounted) {
        context.hideLoader();
      }
    }
    return processResponse(response);
  }
}

class SuccessfulResponse {
  final String body;
  final int statusCode;

  SuccessfulResponse(this.body, this.statusCode);
}
