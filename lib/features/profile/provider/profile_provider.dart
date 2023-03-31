import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  bool isCurrentUser = true;
  int userId = -1;
  bool isFollow = false;
  int followers = 0;
  String profileImg = "";
  bool isCamera = false;
  String route = "";

  setProfile(isCurrentUser, userId) {
    this.isCurrentUser = isCurrentUser;
    this.userId = userId;
  }

  setIsFollow(data) {
    isFollow = data;
    notifyListeners();
  }

  setFollowers(data) {
    followers = data;
    notifyListeners();
  }

  setProfileImg(img) {
    profileImg = img;
    notifyListeners();
  }

  setRoute(data) {
    route = data;
  }

}