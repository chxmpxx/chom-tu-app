import 'dart:convert';

import 'package:chom_tu/constants/api_constant.dart';
import 'package:chom_tu/features/outfit/providers/outfit_controller.dart';
import 'package:chom_tu/features/wardrobe/models/wardrobe_model.dart';
import 'package:http/http.dart' as http;

class WardrobeController {

  Future<String> addWardrobe(WardrobeModel data, path) async {
    var request = http.MultipartRequest('POST', Uri.parse("$wardrobeURLAPI/add_wardrobe"));
    request.headers.addAll(await setHeaders());
    request.fields.addAll(wardrobeModelToMap(data));
    request.files.add(await http.MultipartFile.fromPath('file', path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return response.toString();
    }
    throw Exception('Fail');
  }

  Future<List<WardrobeModel>> getAllWardrobes(category, colors, types, sort, wardrobeIdList, bottom, [isOutfit = false]) async {
    var order = [["updatedAt", "DESC"]];
    if (sort == 'Oldest') {
      order = [["updatedAt", "ASC"]];
    }

    String data = jsonEncode({"category": category, "color": colors, "type": types, "wardrobeIdList": wardrobeIdList, "bottom": bottom, "isOutfit": isOutfit, "order": order});
    final response = await http.post(Uri.parse("$wardrobeURLAPI/all_wardrobe"), headers: await setHeaders(), body: data);

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
    final response = await http.post(Uri.parse("$wardrobeURLAPI/all_fav_wardrobe"), headers: await setHeaders(), body: data);
    if (response.statusCode == 200) {
      return wardrobeListModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<WardrobeModel> getOneWardrobe(id) async {
    final response = await http.get(Uri.parse("$wardrobeURLAPI/$id"), headers: await setHeaders());
    if (response.statusCode == 200) {
      return wardrobeModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<List<int>> getOutfitIdFromWardrobe(id) async {
    final response = await http.get(Uri.parse("$wardrobeURLAPI/outfit_id_from_wardrobe/$id"), headers: await setHeaders());
    if (response.statusCode == 200) {
      return List<int>.from(jsonDecode(response.body));
    }
    throw Exception('Fail');
  }

  Future<String> updateWardrobe(wardrobeId, WardrobeModel data, [path = '-1']) async {
    var request = http.MultipartRequest('PUT', Uri.parse("$wardrobeURLAPI/$wardrobeId"));
    request.headers.addAll(await setHeaders());
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
    final response = await http.post(Uri.parse("$wardrobeURLAPI/fav_wardrobe/$id"), headers: await setHeaders(), body: data);
    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Fail');
  }

  Future<String> deleteWardrobe(id, List<int> outfitIdList) async {
    final response = await http.delete(Uri.parse("$wardrobeURLAPI/$id"), headers: await setHeaders());
    if (response.statusCode == 200) {

      // Delete Outfit and Components
      outfitIdList.forEach((outfitId) async {
        await OutfitController().deleteOutfit(outfitId);
      });
      return response.body;
    }
    throw Exception('Fail');
  }

  Future<Map<String, dynamic>> wardrobeDetection(path, bool isDetect) async {
    var request = http.MultipartRequest('POST', Uri.parse("$wardrobeURLAPI/detect_wardrobe"));
    Map<String, String> data = {"is_detect": isDetect.toString()};

    request.headers.addAll(await setHeaders());
    request.fields.addAll(data);
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