import 'package:flutter/cupertino.dart';

class DeleteItemProvider extends ValueNotifier<int> {
  DeleteItemProvider({int deleteItem = 0}) : super(deleteItem);

  setDeleteItem() {
    value++;
  }

  get deleteItem => value;
}