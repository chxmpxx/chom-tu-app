import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  String imagePath = '';
  String caption = '';
  int postId = 0;

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

  setPostId(id) {
    postId = id;
    notifyListeners();
  }

}