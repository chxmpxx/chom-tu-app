import 'package:flutter/material.dart';

class OutfitCreateProvider with ChangeNotifier {

  bool tabStatus = false;

  SelectTab() {
    tabStatus == true ? tabStatus = false : tabStatus = true;
    notifyListeners();
  }

}