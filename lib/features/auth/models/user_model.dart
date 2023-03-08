import 'dart:convert';

List<UserModel> userListModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<UserModel>.from(data.map((element) => UserModel.fromJson(element)));
}

UserModel userModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return UserModel.fromJson(data);
}

String userModelToJson(UserModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

Map<String, String> userModelToMap(UserModel data) {
  return {
    "name": data.name,
    "email": data.email,
    "username": data.username,
    "password": data.password!
  };
}

class UserModel {
  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.username,
    this.password,
    this.confirmPassword,
    this.bio,
    this.userImg,
    this.totalCharges,
    this.isBan,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String name;
  String email;
  String username;
  String? password;
  String? confirmPassword;
  String? bio;
  String? userImg;
  int? totalCharges;
  bool? isBan;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    username: json["username"],
    password: json["password"],
    bio: json["bio"],
    userImg: json["user_img"],
    totalCharges: json["total_charges"],
    isBan: json["is_ban"],
    role: json["role"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "username": username,
    "password": password,
    "confirm_password": confirmPassword
  };
}
