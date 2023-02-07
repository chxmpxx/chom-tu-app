import 'package:flutter/material.dart';

class OutfitFilterTabProvider with ChangeNotifier {

  bool tabStatus = false;
  int indexTab = -1;
  String sort = 'Newest';
  String style = 'None';

  filterTab(int index) {
    indexTab == index ? (tabStatus ? tabStatus = false : tabStatus = true) : tabStatus = true;
    indexTab = index;
    notifyListeners();
  }

  selectSort(String value) {
    sort = value;
    notifyListeners();
  }

  selectStyle(String value) {
    style = value;
    notifyListeners();
  }

}