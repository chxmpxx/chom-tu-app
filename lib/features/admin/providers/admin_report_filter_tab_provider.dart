import 'package:flutter/material.dart';

class AdminReportFilterTabProvider with ChangeNotifier {

  bool tabStatus = false;
  int indexTab = -1;
  String sort = 'Newest';
  List<String> details = [];

  filterTab(int index) {
    indexTab == index ? (tabStatus ? tabStatus = false : tabStatus = true) : tabStatus = true;
    indexTab = index;
    notifyListeners();
  }

  selectSort(String value) {
    sort = value;
    notifyListeners();
  }

  addDetails(String detail) {
    details.add(detail);
    notifyListeners();
  }
  removeDetails(String detail) {
    details.remove(detail);
    notifyListeners();
  }
  removeAllDetails() {
    details = [];
    notifyListeners();
  }

  removeAllFilterTab() {
    sort = 'Newest';
    details = [];
    notifyListeners();
  }
}