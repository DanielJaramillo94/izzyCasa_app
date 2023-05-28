import 'package:flutter/material.dart';

extension LoaderExtension on BuildContext {
  static bool _loaderIsShowing = false;
  void showLoader() {
    _loaderIsShowing = true;
    showDialog(
      context: this,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const SizedBox(
          width: 30,
          height: 30,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  void hideLoader() {
    if (_loaderIsShowing) {
      Navigator.of(this).pop();
      _loaderIsShowing = false;
    }
  }

  void showErrorSnackBar(
      [String? errorMessage =
          'Ocurrió un error, por favor inténtalo más tarde']) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
            errorMessage ?? 'Ocurrió un error, por favor inténtalo más tarde'),
      ),
    );
  }

  void showSuccessSnackBar([String? message]) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message ?? 'Cambios realizados'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
