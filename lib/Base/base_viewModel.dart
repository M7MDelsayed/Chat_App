import 'package:chat_app/Base/base_navigator.dart';
import 'package:flutter/material.dart';

class BaseViewModel<NAV extends BaseNavigator> extends ChangeNotifier {
  NAV? navigator;
}
