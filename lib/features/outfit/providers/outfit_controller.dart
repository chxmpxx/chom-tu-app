import 'dart:convert';

import 'package:chom_tu/constants/api_constant.dart';
import 'package:chom_tu/features/outfit/models/component_model.dart';
import 'package:chom_tu/features/outfit/models/outfit_model.dart';
import 'package:chom_tu/utils/get_value_from_key_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class OutfitController {

  Future<String> addOutfit(OutfitModel data, path, Map<Key, Map<String, double>> offset) async {
    var request = http.MultipartRequest('POST', Uri.parse("$outfitURLAPI/add_outfit"));
    request.fields.addAll(outfitModelToMap(data));
    request.files.add(await http.MultipartFile.fromPath('file', path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String res = await response.stream.transform(utf8.decoder).join();
      int outfitId = json.decode(res);

      // Create Components
      offset.forEach((k, v) async {
        ComponentModel dataComp = ComponentModel(wardrobeId: int.parse(getValueFromKeyType(k)), outfitId: outfitId, position: v.toString());

        final resComp = await http.post(Uri.parse("$componentURLAPI/add_component"), headers: setHeaders(), body: componentModelToJson(dataComp));
        if (resComp.statusCode != 200) {
          throw Exception('Fail');
        }
      });

      return response.toString();
    }
    throw Exception('Fail');
  }

  Future<List<OutfitModel>> getAllOutfits(sort, style) async {
    var order = [["updatedAt", "DESC"]];
    if (sort == 'Oldest') {
      order = [["updatedAt", "ASC"]];
    }

    String data = jsonEncode({"order": order, "style": style});
    final response = await http.post(Uri.parse("$outfitURLAPI/all_outfit"), headers: setHeaders(), body: data);

    if (response.statusCode == 200) {
      return outfitListModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<List<OutfitModel>> getAllFavOutfits(sort, style) async {
    var order = [["updatedAt", "DESC"]];
    if (sort == 'Oldest') {
      order = [["updatedAt", "ASC"]];
    }

    String data = jsonEncode({"order": order, "style": style});
    final response = await http.post(Uri.parse("$outfitURLAPI/all_fav_outfit"), headers: setHeaders(), body: data);
    
    if (response.statusCode == 200) {
      return outfitListModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<OutfitModel> getOneOutfit(id) async {
    final response = await http.get(Uri.parse("$outfitURLAPI/$id"), headers: setHeaders());
    if (response.statusCode == 200) {
      return outfitModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<List<String>> getStyle(id) async {
    final response = await http.get(Uri.parse("$outfitURLAPI/get_style/$id"), headers: setHeaders());
    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    }
    throw Exception('Fail');
  }

  Future<String> favOutfit(id, data) async {
    final response = await http.post(Uri.parse("$outfitURLAPI/fav_outfit/$id"), headers: setHeaders(), body: data);
    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Fail');
  }
}