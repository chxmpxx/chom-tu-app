import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  String imagePath = '';
  String caption = '';

  setPostImage(img) {
    imagePath = img;
    notifyListeners();
  }

  setCaption(data) {
    caption = data;
  }

  removePostImage() {
    imagePath = '';
  }

}