import 'package:flutter/material.dart';

class OutfitCreateProvider with ChangeNotifier {

  bool tabStatus = false;
  String? top, bottom, set, shoes, accessory;

  SelectTab() {
    tabStatus == true ? tabStatus = false : tabStatus = true;
    notifyListeners();
  }

  SelectTop(top) {
    this.top = top;
    notifyListeners();
  }

  String GetTop() {
    return top!;
  }
  
  SelectBottom(bottom) {
    this.bottom = bottom;
    notifyListeners();
  }

  String GetBottom() {
    return bottom!;
  }

  SelectSet(set) {
    this.set = set;
    notifyListeners();
  }

  String GetSet() {
    return set!;
  }

  Selectshoes(shoes) {
    this.shoes = shoes;
    notifyListeners();
  }

  String Getshoes() {
    return shoes!;
  }

  SelectAccessory(accessory) {
    this.accessory = accessory;
    notifyListeners();
  }

  String GetAccessory() {
    return accessory!;
  }

}