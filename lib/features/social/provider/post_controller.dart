import 'dart:convert';

import 'package:chom_tu/constants/api_constant.dart';
import 'package:chom_tu/features/auth/models/user_model.dart';
import 'package:chom_tu/features/social/models/post_model.dart';
import 'package:http/http.dart' as http;

class PostController {

  Future<String> addPost(PostModel data, path) async {
    var request = http.MultipartRequest('POST', Uri.parse("$postURLAPI/add_post"));
    request.headers.addAll(await setHeaders());
    request.fields.addAll(postModelToMap(data));
    request.files.add(await http.MultipartFile.fromPath('file', path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return response.toString();
    }
    throw Exception('Fail');
  }

  Future<List<PostModel>> getAllPosts() async {
    final response = await http.post(Uri.parse("$postURLAPI/all_post"), headers: await setHeaders(), body: json.encode({}));

    if (response.statusCode == 200) {
      return postListModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<Map<String, dynamic>> getAllProfilePosts(bool isCurrentUser, int id) async {
    final response = await http.get(Uri.parse("$postURLAPI/all_profile_post/$id/$isCurrentUser"), headers: await setHeaders());

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      List<PostModel> postList = postListModelFromJson(jsonEncode(data['posts']));
      UserModel user = userModelFromJson(jsonEncode(data['user']));

      int posts = postList.length;
      int followers = data['followers'] as int;
      int following = data['following'] as int;
      Map<String, int> quantity = {'posts': posts, 'followers': followers, 'following': following};

      bool isFollow = data['is_follow'] as bool;

      return {'posts': postList, 'user': user, 'quantity': quantity, 'is_follow': isFollow};
    }
    throw Exception('Fail');
  }

  Future<PostModel> getOnePost(id) async {
    final response = await http.get(Uri.parse("$postURLAPI/$id"), headers: await setHeaders());
    if (response.statusCode == 200) {
      return postModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<String> updatePost(id, Map<String, String> data) async {
    final response = await http.put(Uri.parse("$postURLAPI/$id"), headers: await setHeaders(), body: json.encode(data));
    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Fail');
  }

  Future<String> deletePost(id) async {
    final response = await http.delete(Uri.parse("$postURLAPI/$id"), headers: await setHeaders());
    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Fail');
  }
}