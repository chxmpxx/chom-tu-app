import 'package:flutter/material.dart';

class AdminProvider with ChangeNotifier {

  String menu = 'User';

  setMenu(String value) {
    menu = value;
    notifyListeners();
  }
}