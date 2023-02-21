import 'package:flutter/material.dart';

class WardrobeFilterTabProvider with ChangeNotifier {

  bool tabStatus = false;
  int indexTab = -1;
  String category = 'Top';
  String sort = 'Newest';
  List<String> colors = [];
  List<String> types = [];
  Map<String, List<String>> bottomTypes = {"skirts": [], "shorts": [], "trousers": []};

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
    colors.add(color);
    notifyListeners();
  }
  removeColors(String color) {
    colors.remove(color);
    notifyListeners();
  }
  removeAllColors() {
    colors = [];
    notifyListeners();
  }

  // type
  addTypes(String type) {
    types.add(type);
    notifyListeners();
  }
  removeTypes(String type) {
    types.remove(type);
    notifyListeners();
  }
  removeAllTypes() {
    types = [];
    notifyListeners();
  }

  // bottom type
  addBottomTypes(String key, String type) {
    bottomTypes[key]!.add(type);
    notifyListeners();
  }
  removeBottomTypes(String key,String type) {
    bottomTypes[key]!.remove(type);
    notifyListeners();
  }
  removeAllBottomTypes() {
    bottomTypes = {};
    notifyListeners();
  }

  selectSort(String value) {
    sort = value;
    notifyListeners();
  }

  removeAllFilterTab() {
    sort = 'Newest';
    colors = [];
    types = [];
    notifyListeners();
  }

  removeAll() {
    category = 'Top';
    sort = 'Newest';
    colors = [];
    types = [];
    notifyListeners();
  }
}