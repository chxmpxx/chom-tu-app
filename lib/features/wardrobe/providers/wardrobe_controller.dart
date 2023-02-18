import 'dart:convert';

import 'package:chom_tu/constants/api_constant.dart';
import 'package:chom_tu/features/wardrobe/models/wardrobe_model.dart';
import 'package:http/http.dart' as http;

class WardrobeController {
  var newWardrobe;

  Future<List<WardrobeModel>> getAllWardrobe(category, colors, types) async {
    String data = jsonEncode({"category": category, "color": colors, "type": types});
    final response = await http.post(Uri.parse("$wardrobeURLAPI/all_wardrobe"), headers: setHeaders(), body: data);
    if (response.statusCode == 200) {
      return wardrobeModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<String> addWardrobe(WardrobeModel data, path) async {
    var request = http.MultipartRequest('POST', Uri.parse("$wardrobeURLAPI/add_wardrobe"));
    request.fields.addAll(wardrobeModelToMap(data));
    request.files.add(await http.MultipartFile.fromPath('file', path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return response.toString();
    }
    throw Exception('Fail');
  }
}