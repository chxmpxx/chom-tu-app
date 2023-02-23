import 'package:flutter/material.dart';

class WardrobeFavBtnProvider with ChangeNotifier {
  bool isFavBtn = false;

  setIsFavBtn(data) {
    isFavBtn = data;
    notifyListeners();
  }
}