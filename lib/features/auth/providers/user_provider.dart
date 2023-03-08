import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  bool existingEmail = false;
  bool existingUsername = false;
  bool passwordNotMatch = false;
  bool noAccount = false;
  bool passwordIncorrect = false;
  bool banned = false;

  // validate

  setExistingEmail(data) {
    existingEmail = data;
    notifyListeners();
  }

  setExistingUsername(data) {
    existingUsername = data;
    notifyListeners();
  }

  setPasswordNotMatch(data) {
    passwordNotMatch = data;
    notifyListeners();
  }

  setNoAccount(data) {
    noAccount = data;
    notifyListeners();
  }

  setPasswordIncorrect(data) {
    passwordIncorrect = data;
    notifyListeners();
  }

  setBanned(data) {
    banned = data;
    notifyListeners();
  }
}