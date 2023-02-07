import 'package:flutter/material.dart';

class WardrobeProvider with ChangeNotifier {

  // image
  bool isGallery = false;
  String? currentPath;
  String? previousPath;

  // info
  // todo: get value from api
  String category = 'Top';
  String subCategory = 'Skirts';
  String color = 'Red';
  String type = 'Vest';

  setPath(String path) {
    if(currentPath == null) {
      previousPath = path;
    } else {
      previousPath = currentPath;
    }
    currentPath = path;
    notifyListeners();
  }

  setData(String name, String data) {
    if (name == 'Category') {
      category = data;
    } else if (name == 'Color') {
      color = data;
    } else if (name == 'Type') {
      type = data;
    } else {
      subCategory = data;
    }
    notifyListeners();
  }

}