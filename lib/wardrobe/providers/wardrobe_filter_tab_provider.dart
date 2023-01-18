import 'package:flutter/material.dart';

class WardrobeFilterTabProvider with ChangeNotifier {

  bool tabStatus = false;
  int indexTab = -1;
  List<String> colors = ['None'];
  String sort = 'Newest';
  List<String> types = ['None'];

  filterTab(int index) {
    indexTab == index ? (tabStatus ? tabStatus = false : tabStatus = true) : tabStatus = true;
    indexTab = index;
    notifyListeners();
  }

  // color
  addColors(String color) {
    if(colors.contains('None')) {
      colors.remove('None');
    }
    colors.add(color);
    notifyListeners();
  }
  removeColors(String color) {
    colors.remove(color);
    notifyListeners();
  }
  removeAllColors() {
    colors = ['None'];
    notifyListeners();
  }

  // type
  addTypes(String type) {
    if(types.contains('None')) {
      types.remove('None');
    }
    types.add(type);
    notifyListeners();
  }
  removeTypes(String type) {
    types.remove(type);
    notifyListeners();
  }
  removeAllTypes() {
    types = ['None'];
    notifyListeners();
  }

  selectSort(String value) {
    sort = value;
    notifyListeners();
  }

}