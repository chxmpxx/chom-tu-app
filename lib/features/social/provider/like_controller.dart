import 'dart:convert';

import 'package:chom_tu/constants/api_constant.dart';
import 'package:http/http.dart' as http;

class LikeController {

  Future<String> addLike(data) async {
    final response = await http.post(Uri.parse("$likeURLAPI/add_like"), headers: setHeaders(), body: json.encode(data));

    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Fail');
  }

  Future<String> unlike(id) async {
    final response = await http.delete(Uri.parse("$likeURLAPI/$id"), headers: setHeaders());
    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Fail');
  }
}