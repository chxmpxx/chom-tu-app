import 'package:flutter/material.dart';

class OutfitFilterTabProvider with ChangeNotifier {

  String sort = 'Newest';
  List<String> styles = [];

  selectSort(String value) {
    sort = value;
    notifyListeners();
  }

  // style
  addStyle(String style) {
    styles.add(style);
    notifyListeners();
  }
  removeStyle(String style) {
    styles.remove(style);
    notifyListeners();
  }
  removeAllStyle() {
    styles = [];
    notifyListeners();
  }

}