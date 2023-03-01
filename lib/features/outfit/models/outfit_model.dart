import 'dart:convert';

List<OutfitModel> outfitListModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<OutfitModel>.from(data.map((element) => OutfitModel.fromJson(element)));
}

OutfitModel outfitModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return OutfitModel.fromJson(data);
}

String outfitModelToJson(OutfitModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

Map<String, String> outfitModelToMap(OutfitModel data) {
  return {
    "user_id": data.userId.toString(),
    "style": data.style,
    "detail": data.detail!,
    "bg_color": data.bgColor,
  };
}

class OutfitModel {
  OutfitModel({
    this.id,
    required this.userId,
    required this.style,
    this.detail,
    this.isFavorite,
    required this.bgColor,
    this.outfitImg,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int userId;
  String style;
  String? detail;
  bool? isFavorite;
  String bgColor;
  String? outfitImg;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory OutfitModel.fromJson(Map<String, dynamic> json) => OutfitModel(
    id: json["id"],
    userId: json["user_id"],
    style: json["style"],
    detail: json["detail"],
    isFavorite: json["is_favorite"],
    bgColor: json["bg_color"],
    outfitImg: json["outfit_img"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "style": style,
    "detail": detail,
    "is_favorite": isFavorite,
    "bg_color": bgColor,
    "outfit_img": outfitImg,
  };
}
