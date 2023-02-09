import 'dart:convert';

import 'package:chom_tu/constants/api_constant.dart';
import 'package:chom_tu/features/wardrobe/models/wardrobe_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WardrobeFilterTabProvider with ChangeNotifier {

  bool tabStatus = false;
  int indexTab = -1;
  String category = 'Top';
  String sort = 'Newest';
  List<String> colors = ['None'];
  List<String> types = ['None'];

  filterTab(int index) {
    indexTab == index ? (tabStatus ? tabStatus = false : tabStatus = true) : tabStatus = true;
    indexTab = index;
    notifyListeners();
  }

  setCategory(String data) {
    category = data;
    notifyListeners();
  }

  // color
  addColors(String color) {
    if(colors.contains('None')) {
      colors.remove('None');
    }
    colors.add(color);
    notifyListeners();
  }
  removeColors(String color) {
    colors.remove(color);
    notifyListeners();
  }
  removeAllColors() {
    colors = ['None'];
    notifyListeners();
  }

  // type
  addTypes(String type) {
    if(types.contains('None')) {
      types.remove('None');
    }
    types.add(type);
    notifyListeners();
  }
  removeTypes(String type) {
    types.remove(type);
    notifyListeners();
  }
  removeAllTypes() {
    types = ['None'];
    notifyListeners();
  }

  selectSort(String value) {
    sort = value;
    notifyListeners();
  }

  removeAllFilterTab() {
    sort = 'Newest';
    colors = ['None'];
    types = ['None'];
    notifyListeners();
  }

  removeAll() {
    category = 'Top';
    sort = 'Newest';
    colors = ['None'];
    types = ['None'];
    notifyListeners();
  }

  // CRUD
  Future<List<WardrobeModel>> getAllWardrobe() async {
    String data = jsonEncode({"category": category, "color": colors, "type": types});
    final response = await http.post(Uri.parse("$wardrobeURLAPI/all_wardrobe"), headers: setHeaders(), body: data);
    if(response.statusCode == 200) {
      print(response.body);
      return wardrobeModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

}