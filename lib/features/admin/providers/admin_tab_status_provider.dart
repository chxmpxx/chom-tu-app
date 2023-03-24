import 'package:flutter/material.dart';

class AdminTabStatusProvider with ChangeNotifier {
  bool status = false;
  int indexTab = -1;

  tab(int index) {
    indexTab == index ? (status ? status = false : status = true) : status = true;
    indexTab = index;
    notifyListeners();
  }
}