import 'package:flutter/material.dart';

class AdminProvider with ChangeNotifier {

  String menu = 'User';
  String charges = '30';
  bool isEditCharges = false;

  setMenu(String value) {
    menu = value;
    notifyListeners();
  }

  setCharges(String value) {
    charges = value;
  }

  setIsEditCharges() {
    isEditCharges = !isEditCharges;
    notifyListeners();
  }

  update() {
    notifyListeners();
  }
}