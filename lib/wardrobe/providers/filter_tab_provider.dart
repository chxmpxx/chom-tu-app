import 'package:flutter/material.dart';

class FilterTabProvider with ChangeNotifier {

  bool tabStatus = false;
  int indexTab = 0;

  filterTab(int index) {
    indexTab == index ? (tabStatus ? tabStatus = false : tabStatus = true) : tabStatus = true;
    indexTab = index;
    notifyListeners();
  }

}