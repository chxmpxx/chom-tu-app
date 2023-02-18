import 'package:flutter/material.dart';

class WardrobeFilterTabProvider with ChangeNotifier {

  bool tabStatus = false;
  int indexTab = -1;
  String category = 'Top';
  String sort = 'Newest';
  List<String> colors = ['None'];
  List<String> types = ['None'];

  filterTab(int index) {
    indexTab == index ? (tabStatus ? tabStatus = false : tabStatus = true) : tabStatus = true;
    indexTab = index;
    notifyListeners();
  }

  setCategory(String value) {
    category = value;
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

  removeAllFilterTab() {
    sort = 'Newest';
    colors = ['None'];
    types = ['None'];
    notifyListeners();
  }

  removeAll() {
    category = 'Top';
    sort = 'Newest';
    colors = ['None'];
    types = ['None'];
    notifyListeners();
  }
}