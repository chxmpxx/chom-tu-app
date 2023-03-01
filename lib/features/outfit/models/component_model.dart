import 'dart:convert';

List<ComponentModel> componentListModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<ComponentModel>.from(data.map((element) => ComponentModel.fromJson(element)));
}

ComponentModel componentModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return ComponentModel.fromJson(data);
}

String componentModelToJson(ComponentModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

Map<String, String> wardrobeModelToMap(ComponentModel data) {
  return {
    "wardrobe_id": data.wardrobeId.toString(),
    "outfit_id": data.outfitId.toString(),
    "position": data.position
  };
}

class ComponentModel {
  ComponentModel({
    this.id,
    required this.wardrobeId,
    required this.outfitId,
    required this.position,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int wardrobeId;
  int outfitId;
  String position;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ComponentModel.fromJson(Map<String, dynamic> json) => ComponentModel(
    id: json["id"],
    wardrobeId: json["wardrobe_id"],
    outfitId: json["outfit_id"],
    position: json["position"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "wardrobe_id": wardrobeId,
    "outfit_id": outfitId,
    "position": position,
  };
}