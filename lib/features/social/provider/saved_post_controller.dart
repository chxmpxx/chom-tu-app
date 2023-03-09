import 'dart:convert';

import 'package:chom_tu/constants/api_constant.dart';
import 'package:chom_tu/features/social/models/post_model.dart';
import 'package:http/http.dart' as http;

class SavedPostController {

  Future<String> addSavedPost(data) async {
    final response = await http.post(Uri.parse("$savedPostURLAPI/add_saved_post"), headers: setHeaders(), body: json.encode(data));

    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Fail');
  }

  Future<List<PostModel>> getAllSavedPosts(id) async {
    // todo: delete id
    final response = await http.get(Uri.parse("$savedPostURLAPI/all_saved_posts/$id"), headers: setHeaders());

    if (response.statusCode == 200) {
      return postListModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<String> unsavedPost(id) async {
    final response = await http.delete(Uri.parse("$savedPostURLAPI/$id"), headers: setHeaders());
    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Fail');
  }
}