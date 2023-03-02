import 'package:flutter/cupertino.dart';

class DashboardProvider extends ValueNotifier<int> {
  DashboardProvider({int currentIndex = 0}) : super(currentIndex);

  setCurrentIndex(index) {
    value = index;
  }

  get currentIndex => value;
}