import 'package:flutter/material.dart';

class WardrobeImageProvider with ChangeNotifier {

  bool isGallery = false;
  String? currentPath;
  String? previousPath;

  setPath(String path) {
    if(currentPath == null) {
      previousPath = path;
    }else {
      previousPath = currentPath;
    }
    currentPath = path;
    notifyListeners();
  }
}