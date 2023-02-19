import 'dart:convert';

List<WardrobeModel> wardrobeListModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<WardrobeModel>.from(data.map((element) => WardrobeModel.fromJson(element)));
}

WardrobeModel wardrobeModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return WardrobeModel.fromJson(data);
}

String wardrobeModelToJson(WardrobeModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

Map<String, String> wardrobeModelToMap(WardrobeModel data) {
  return {
    "user_id": data.userId.toString(),
    "category": data.category,
    "sub_category": data.subCategory,
    "color": data.color,
    "type": data.type,
  };
}

class WardrobeModel {
  WardrobeModel({
    this.id,
    required this.userId,
    required this.category,
    required this.subCategory,
    required this.color,
    required this.type,
    this.isFavorite,
    this.wardrobeImg,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int userId;
  String category;
  String subCategory;
  String color;
  String type;
  bool? isFavorite;
  String? wardrobeImg;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory WardrobeModel.fromJson(Map<String, dynamic> json) => WardrobeModel(
    id: json["id"],
    userId: json["user_id"],
    category: json["category"],
    subCategory: json["sub_category"],
    color: json["color"],
    type: json["type"],
    isFavorite: json["is_favorite"],
    wardrobeImg: json["wardrobe_img"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "category": category,
    "sub_category": subCategory,
    "color": color,
    "type": type,
  };
}
