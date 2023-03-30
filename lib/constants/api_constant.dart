import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const protocol = "http";
const domain = "10.4.248.213:3000";

const wardrobeURLAPI = "$protocol://$domain/api/wardrobe";
const outfitURLAPI = "$protocol://$domain/api/outfit";
const componentURLAPI = "$protocol://$domain/api/component";
const postURLAPI = "$protocol://$domain/api/post";
const userURLAPI = "$protocol://$domain/api/user";
const likeURLAPI = "$protocol://$domain/api/like";
const savedPostURLAPI = "$protocol://$domain/api/saved_post";
const reportURLAPI = "$protocol://$domain/api/report";
const followerURLAPI = "$protocol://$domain/api/follower";

Future<Map<String, String>> setHeaders() async {
  const storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'accessToken');

  return {
    'Content-Type':'application/json',
    'Accept':'application/json',
    'Authorization':'Bearer $token'
  };
}