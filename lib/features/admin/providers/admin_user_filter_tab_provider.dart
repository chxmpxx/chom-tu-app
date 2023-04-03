import 'package:flutter/material.dart';

class AdminUserFilterTabProvider with ChangeNotifier {

  bool tabStatus = false;
  int indexTab = -1;
  String menu = 'User';
  // String sort = 'Newest';
  String charges = 'Sort Lowest to Highest';
  String status = 'All';

  filterTab(int index) {
    indexTab == index ? (tabStatus ? tabStatus = false : tabStatus = true) : tabStatus = true;
    indexTab = index;
    notifyListeners();
  }

  setMenu(String value) {
    menu = value;
    notifyListeners();
  }

  // selectSort(String value) {
  //   sort = value;
  //   notifyListeners();
  // }

  selectCharges(String value) {
    charges = value;
    notifyListeners();
  }

  selectStatus(String value) {
    status = value;
    notifyListeners();
  }

  removeAllFilterTab() {
    // sort = 'Newest';
    charges = 'Sort Lowest to Highest';
    status = 'All';
    notifyListeners();
  }
}