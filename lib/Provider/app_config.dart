import 'package:chat_app/Model/my_user.dart';
import 'package:flutter/material.dart';

class AppConfig extends ChangeNotifier {
  MyUser? myUser;

  void updateUser(MyUser newUser) {
    myUser = newUser;
    notifyListeners();
  }
}
