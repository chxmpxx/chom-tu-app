import 'package:flutter/material.dart';

class WardrobeProvider with ChangeNotifier {

  // image
  bool isGallery = false;
  String? currentPath;
  String? previousPath;
  // if isEditImage = false -> don't change image in firebase
  bool isEditImage = false;

  // info
  String category = 'Top';
  String subCategory = 'Skirts';
  String color = 'Red';
  String type = 'Vest';
  String? image;

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

  setImage(String data) {
    image = data;
    notifyListeners();
  }
}