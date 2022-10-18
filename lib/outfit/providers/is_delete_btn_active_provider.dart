import 'package:flutter/cupertino.dart';

class IsDeleteBtnActiveProvider extends ValueNotifier<bool> {
  IsDeleteBtnActiveProvider({bool isDeleteBtnActive = false}) : super(isDeleteBtnActive);

  setIsDeleteBtnActive(status) {
    value = status;
  }

  get isDeleteBtnActive => value;
}