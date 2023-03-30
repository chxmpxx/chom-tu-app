import 'dart:convert';

import 'package:chom_tu/constants/api_constant.dart';
import 'package:chom_tu/features/auth/models/user_model.dart';
import 'package:http/http.dart' as http;

class FollowerController {

  Future<String> addFollow(id) async {
    final response = await http.post(Uri.parse("$followerURLAPI/add_follow/$id"), headers: await setHeaders(), body: json.encode({}));

    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Fail');
  }

  Future<List<UserModel>> getFollow(data) async {
    final response = await http.post(Uri.parse("$followerURLAPI/get_follow"), headers: await setHeaders(), body: json.encode(data));

    if (response.statusCode == 200) {
      return userListModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<String> unfollow(id) async {
    final response = await http.delete(Uri.parse("$followerURLAPI/$id"), headers: await setHeaders());
    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Fail');
  }
}