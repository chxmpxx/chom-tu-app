import 'package:flutter/material.dart';

class WardrobeFilterTabProvider with ChangeNotifier {

  bool tabStatus = false;
  int indexTab = -1;
  String color = 'None';
  String sort = 'Newest';
  String type = 'None';

  filterTab(int index) {
    indexTab == index ? (tabStatus ? tabStatus = false : tabStatus = true) : tabStatus = true;
    indexTab = index;
    notifyListeners();
  }

  selectColor(String value) {
    color = value;
    notifyListeners();
  }

  selectSort(String value) {
    sort = value;
    notifyListeners();
  }

  selectType(String value) {
    type = value;
    notifyListeners();
  }

}