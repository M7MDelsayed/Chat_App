import 'package:chat_app/Base/base_navigator.dart';
import 'package:chat_app/Base/base_viewModel.dart';
import 'package:flutter/material.dart';

import '../components.dart';

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel;

  VM initViewModel();

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;
  }

  @override
  void hideLoading() {
    Navigator.pop(context);
  }

  @override
  void showLoading(String message) {
    DialogUtils.showLoading(context, message);
  }

  @override
  void showMessage(String message, String posButton, VoidCallback posAction,
      {String? negButton,
      VoidCallback? negAction,
      bool isDismissible = false}) {
    DialogUtils.showMessage(context, message, posButton, posAction,
        negButton: negButton,
        negAction: negAction,
        isDismissible: isDismissible);
  }
}
