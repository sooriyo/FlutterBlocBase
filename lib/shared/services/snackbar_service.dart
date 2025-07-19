import 'package:flutter/material.dart';

class SnackbarService {
  static final GlobalKey<ScaffoldMessengerState> _messengerKey = GlobalKey<ScaffoldMessengerState>();

  GlobalKey<ScaffoldMessengerState> get messengerKey => _messengerKey;

  void showSuccess(String message, {Duration duration = const Duration(seconds: 3)}) {
    if (_messengerKey.currentState?.mounted ?? false) {
      _messengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          duration: duration,
        ),
      );
    }
  }

  void showError(String message, {Duration duration = const Duration(seconds: 3)}) {
    if (_messengerKey.currentState?.mounted ?? false) {
      _messengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: duration,
        ),
      );
    }
  }

  void showInfo(String message, {Duration duration = const Duration(seconds: 3)}) {
    if (_messengerKey.currentState?.mounted ?? false) {
      _messengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.blue,
          duration: duration,
        ),
      );
    }
  }
}