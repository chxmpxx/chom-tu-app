import 'dart:convert';

List<WardrobeModel> wardrobeModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<WardrobeModel>.from(data.map((element) => WardrobeModel.fromJson(element)));
}

String wardrobeModelToJson(WardrobeModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

class WardrobeModel {
  WardrobeModel({
    required this.id,
    required this.userId,
    required this.category,
    required this.subCategory,
    required this.color,
    required this.type,
    required this.isFavorite,
    required this.wardrobeImg,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  String category;
  String subCategory;
  String color;
  String type;
  bool isFavorite;
  String wardrobeImg;
  DateTime createdAt;
  DateTime updatedAt;

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
    "id": id,
    "user_id": userId,
    "category": category,
    "sub_category": subCategory,
    "color": color,
    "type": type,
    "is_favorite": isFavorite,
    "wardrobe_img": wardrobeImg,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
