import 'package:flutter/material.dart';

class WardrobeTabStatusProvider with ChangeNotifier {
  bool status = false;
  int indexTab = -1;

  tab(int index) {
    indexTab == index ? (status ? status = false : status = true) : status = true;
    indexTab = index;
    notifyListeners();
  }
}