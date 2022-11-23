import 'package:flutter/material.dart';

class EditTabProvider with ChangeNotifier {

  bool tabStatus = false;
  bool isGallery = false;
  String? currentPath;

  editTab() {
    tabStatus ? tabStatus = false : tabStatus = true;
    notifyListeners();
  }

  setPath(String path) {
    currentPath = path;
    notifyListeners();
  }

}