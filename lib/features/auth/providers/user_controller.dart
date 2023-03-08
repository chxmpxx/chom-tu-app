import 'dart:convert';

import 'package:chom_tu/constants/api_constant.dart';
import 'package:chom_tu/features/auth/models/user_model.dart';
import 'package:chom_tu/features/auth/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UserController {
  Future<dynamic> signUp(data, context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    final response = await http.post(Uri.parse("$userURLAPI/sign_up"), headers: setHeaders(), body: userModelToJson(data));
    
    if (response.statusCode == 200) {
      userProvider.setExistingEmail(false);
      userProvider.setExistingUsername(false);
      userProvider.setPasswordNotMatch(false);

      return userModelFromJson(response.body);
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

  Future<dynamic> login(data, context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    final response = await http.post(Uri.parse("$userURLAPI/login"), headers: setHeaders(), body: jsonEncode(data));

    if (response.statusCode == 200) {
      userProvider.setNoAccount(false);
      userProvider.setPasswordIncorrect(false);
      userProvider.setBanned(false);
      return userModelFromJson(response.body);
    } else if (response.statusCode == 400) {
      Map<String, dynamic> res = json.decode(response.body);

      if(res["account"] == 'noAccount') {
        userProvider.setNoAccount(true);
      } else {
        userProvider.setNoAccount(false);
      }
      if(res["password"] == 'passwordIncorrect'){
        userProvider.setPasswordIncorrect(true);
      } else {
        userProvider.setPasswordIncorrect(false);
      }
      if(res["ban"] == 'banned'){
        userProvider.setBanned(true);
      } else {
        userProvider.setBanned(false);
      }
      return response.body;
    } 
    throw Exception('Fail');
  }
}