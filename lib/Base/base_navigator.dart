import 'package:flutter/material.dart';

abstract class BaseNavigator {
  void showLoading(String message);

  void hideLoading();

  void showMessage(String message, String posButton, VoidCallback posAction,
      {String? negButton, VoidCallback? negAction, bool isDismissible = false});
}
