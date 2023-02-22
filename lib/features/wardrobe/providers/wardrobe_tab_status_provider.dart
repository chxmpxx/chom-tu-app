import 'package:flutter/material.dart';

class WardrobeTabStatusProvider extends ValueNotifier<bool> {
  WardrobeTabStatusProvider({bool tabStatus = false}) : super(tabStatus);

  setTabStatus(data) {
    value = data;
  }

  get tabStatus => value;
}