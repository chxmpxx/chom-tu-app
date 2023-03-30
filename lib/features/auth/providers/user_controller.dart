import 'dart:convert';

import 'package:chom_tu/constants/api_constant.dart';
import 'package:chom_tu/features/auth/models/user_model.dart';
import 'package:chom_tu/features/auth/providers/user_provider.dart';
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

  Future<void> login(data, context) async {
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
    } 
  }

  Future<List<UserModel>> getAllUsers(String username) async {
    String data = jsonEncode({"username": username});
    final response = await http.post(Uri.parse("$userURLAPI/search_user"), headers: await setHeaders(), body: data);

    if (response.statusCode == 200) {
      return userListModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<UserModel> getOneUser(bool isCurrentUser, int id) async {
    final response = await http.get(Uri.parse("$userURLAPI/$id"), headers: await setHeaders());
    if (response.statusCode == 200) {
      return userModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

}