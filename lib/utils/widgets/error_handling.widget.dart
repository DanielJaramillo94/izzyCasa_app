import 'dart:async';

import 'package:flutter/material.dart';
import 'package:izzy_casa_app/models/system/snackbar_message.dart';
import 'package:izzy_casa_app/utils/custom_http_client.dart';
import 'package:izzy_casa_app/utils/locator.dart';

class ErrorHandlerWidget extends StatefulWidget {
  final Widget child;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  const ErrorHandlerWidget(
    this.child, {
    super.key,
    required this.scaffoldMessengerKey,
  });

  @override
  State<ErrorHandlerWidget> createState() => _ErrorHandlerWidgetState();
}

class _ErrorHandlerWidgetState extends State<ErrorHandlerWidget> {
  StreamController<SnackBarMessage?> errorStreamController =
      StreamController<SnackBarMessage>();

  @override
  void initState() {
    super.initState();
    getIt
        .get<CustomHttpClient>()
        .addErrorStreamSink(errorStreamController.sink);
    errorStreamController.stream.listen((snackBarMessage) {
      widget.scaffoldMessengerKey.currentState?.clearSnackBars();
      widget.scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text(snackBarMessage?.message ?? '')),
      );

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    errorStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
