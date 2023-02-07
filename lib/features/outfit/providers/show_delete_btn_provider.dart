import 'package:flutter/cupertino.dart';

class ShowDeleteBtnProvider extends ValueNotifier<bool> {
  ShowDeleteBtnProvider({bool showDeleteBtn = false}) : super(showDeleteBtn);

  setShowDeleteBtn(status) {
    value = status;
  }

  get showDeleteBtn => value;
}