import 'package:flutter/material.dart';

class AdminControllerProvider with ChangeNotifier {

  String menu = 'User';

  setMenu(String value) {
    menu = value;
    notifyListeners();
  }
}