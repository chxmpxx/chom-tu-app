import 'package:flutter/material.dart';

class OutfitFavBtnProvider with ChangeNotifier {
  bool isFavBtn = false;

  setIsFavBtn(data) {
    isFavBtn = data;
    notifyListeners();
  }
}