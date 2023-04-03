import 'dart:convert';

import 'package:chom_tu/constants/api_constant.dart';
import 'package:chom_tu/features/auth/models/user_model.dart';
import 'package:chom_tu/features/auth/providers/user_provider.dart';
import 'package:chom_tu/features/profile/provider/profile_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UserController {
  Future<dynamic> signUp(data, context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    final response = await http.post(Uri.parse("$userURLAPI/sign_up"), headers: await setHeaders(), body: userModelToJson(data));
    
    if (response.statusCode == 200) {
      userProvider.setExistingEmail(false);
      userProvider.setExistingUsername(false);
      userProvider.setPasswordNotMatch(false);
      return response.body;
      
    } else if (response.statusCode == 400) {
      Map<String, dynamic> res = json.decode(response.body);

      if(res["email"] == 'existingEmail') {
        userProvider.setExistingEmail(true);
      } else {
        userProvider.setExistingEmail(false);
      }
      if(res["username"] == 'existingUsername'){
        userProvider.setExistingUsername(true);
      } else {
        userProvider.setExistingUsername(false);
      }
      if(res["password"] == 'passwordNotMatch'){
        userProvider.setPasswordNotMatch(true);
      } else {
        userProvider.setPasswordNotMatch(false);
      }
      return response.body;
    } 
    throw Exception('Fail');
  }

  Future<String> login(data, context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    Map<String, String> headers = {
      'Content-Type':'application/json',
      'Accept':'application/json'
    };
    final response = await http.post(Uri.parse("$userURLAPI/login"), headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      userProvider.setNoAccount(false);
      userProvider.setPasswordIncorrect(false);
      userProvider.setBanned(false);

      const storage = FlutterSecureStorage();
      var body = json.decode(response.body);
      String token = body['accessToken'];
      await storage.write(key: 'accessToken', value: token);

      return body['role'];

    } else if (response.statusCode == 400) {
      Map<String, dynamic> res = json.decode(response.body);

      if (res["account"] == 'noAccount') {
        userProvider.setNoAccount(true);
      } else {
        userProvider.setNoAccount(false);
      }
      if (res["password"] == 'passwordIncorrect'){
        userProvider.setPasswordIncorrect(true);
      } else {
        userProvider.setPasswordIncorrect(false);
      }
      if (res["ban"] == 'banned'){
        userProvider.setBanned(true);
      } else {
        userProvider.setBanned(false);
      }
      return response.body;
    } 
    throw Exception('Fail');
  }

  Future<List<UserModel>> searchUser(String username) async {
    String data = jsonEncode({"username": username});
    final response = await http.post(Uri.parse("$userURLAPI/search_user"), headers: await setHeaders(), body: data);

    if (response.statusCode == 200) {
      return userListModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<UserModel> getCurrentUser() async {
    final response = await http.get(Uri.parse("$userURLAPI/current_user"), headers: await setHeaders());
    if (response.statusCode == 200) {
      return userModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<List<UserModel>> getAllUser(charges, status) async {
    var order = [["total_charges", "DESC"]];
    if (charges == 'Sort Highest to Lowest') {
      order = [["total_charges", "ASC"]];
    }

    var userStatus = (status == 'Active' ? 0 : 1);
    if (status == 'All') {
      userStatus = -1 ;
    }

    String data = jsonEncode({ "order": order, "is_ban": userStatus});
    final response = await http.post(Uri.parse("$userURLAPI/all_user"), headers: await setHeaders(), body: data);

    if (response.statusCode == 200) {
      return userListModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<UserModel> getUser(id) async {
    final response = await http.get(Uri.parse("$userURLAPI/get_user/$id"), headers: await setHeaders());
    if (response.statusCode == 200) {
      return userModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<String> updateUserStatus(id, Map<String, String> data) async {
    final response = await http.put(Uri.parse("$userURLAPI/update_status_user/$id"), headers: await setHeaders(), body: json.encode(data));
    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Fail');
  }

  Future<String> updateUser(Map<String, String> data, context) async {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    var request = http.MultipartRequest('PUT', Uri.parse("$userURLAPI/update_user"));
    request.headers.addAll(await setHeaders());
    request.fields.addAll(data);
    if (profileProvider.profileImg != "" ) {
      request.files.add(await http.MultipartFile.fromPath('file', profileProvider.profileImg));
    }
    
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      userProvider.setExistingUsername(false);
      return response.toString();

    } else if (response.statusCode == 400) {
      var responseData = await response.stream.bytesToString();
      Map<String, dynamic> res = json.decode(responseData);

      if (res["username"] == 'existingUsername'){
        userProvider.setExistingUsername(true);
      } else {
        userProvider.setExistingUsername(false);
      }
      return response.toString();
    } 
    throw Exception('Fail');
  }

  Future<String> changePassword(Map<String, String> data, context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    final response = await http.post(Uri.parse("$userURLAPI/change_password"), headers: await setHeaders(), body: json.encode(data));
    
    if (response.statusCode == 200) {
      userProvider.setPasswordIncorrect(false);
      userProvider.setPasswordNotMatch(false);
      return response.body;

    } else if (response.statusCode == 400) {
      Map<String, dynamic> res = json.decode(response.body);
      
      if (res["password"] == 'passwordIncorrect'){
        userProvider.setPasswordIncorrect(true);
      } else {
        userProvider.setPasswordIncorrect(false);
      }
      if(res["new_password"] == 'passwordNotMatch'){
        userProvider.setPasswordNotMatch(true);
      } else {
        userProvider.setPasswordNotMatch(false);
      }
      return response.toString();
    }
    throw Exception('Fail');
  }

  Future<String> automaticBanUser(Map<String, String> data) async {
    final response = await http.put(Uri.parse("$userURLAPI/automatic_ban_user"), headers: await setHeaders(), body: json.encode(data));
    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Fail');
  }

}