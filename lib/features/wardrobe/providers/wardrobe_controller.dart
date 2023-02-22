import 'dart:convert';

import 'package:chom_tu/constants/api_constant.dart';
import 'package:chom_tu/features/wardrobe/models/wardrobe_model.dart';
import 'package:http/http.dart' as http;

class WardrobeController {

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

  Future<List<WardrobeModel>> getAllWardrobes(category, colors, types, sort, [isBottom = false]) async {
    var order = [["updatedAt", "DESC"]];
    if (sort == 'Oldest') {
      order = [["updatedAt", "ASC"]];
    }

    String data = jsonEncode({"category": category, "color": colors, "type": types, "isBottom": isBottom, "order": order});
    final response = await http.post(Uri.parse("$wardrobeURLAPI/all_wardrobe"), headers: setHeaders(), body: data);
    if (response.statusCode == 200) {
      return wardrobeListModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<List<WardrobeModel>> getAllFavWardrobes(sort, colors) async {
    var order = [["updatedAt", "DESC"]];
    if (sort == 'Oldest') {
      order = [["updatedAt", "ASC"]];
    }

    String data = jsonEncode({"order": order, "color": colors});
    final response = await http.post(Uri.parse("$wardrobeURLAPI/all_fav_wardrobe"), headers: setHeaders(), body: data);
    if (response.statusCode == 200) {
      return wardrobeListModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<WardrobeModel> getOneWardrobe(id) async {
    final response = await http.get(Uri.parse("$wardrobeURLAPI/$id"), headers: setHeaders());
    if (response.statusCode == 200) {
      return wardrobeModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<String> updateWardrobe(wardrobeId, WardrobeModel data, [path = '-1']) async {
    var request = http.MultipartRequest('PUT', Uri.parse("$wardrobeURLAPI/$wardrobeId"));
    request.fields.addAll(wardrobeModelToMap(data));

    // change image in firebase
    if(path != '-1') {
      request.files.add(await http.MultipartFile.fromPath('file', path));
    }
    
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return response.toString();
    }
    throw Exception('Fail');
  }

  Future<String> favWardrobe(id, data) async {
    final response = await http.post(Uri.parse("$wardrobeURLAPI/fav_wardrobe/$id"), headers: setHeaders(), body: data);
    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Fail');
  }

  Future<String> deleteWardrobe(id) async {
    final response = await http.delete(Uri.parse("$wardrobeURLAPI/$id"), headers: setHeaders());
    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Fail');
  }

  Future<Map<String, dynamic>> wardrobeDetection(path) async {
    var request = http.MultipartRequest('POST', Uri.parse("$wardrobeURLAPI/detect_wardrobe"));
    request.files.add(await http.MultipartFile.fromPath('file', path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String res = await response.stream.transform(utf8.decoder).join();
      Map<String, dynamic> data = json.decode(res) as Map<String, dynamic>;
      return data;
    }
    throw Exception('Fail');
  }
}