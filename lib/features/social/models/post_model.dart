import 'dart:convert';

List<PostModel> postListModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<PostModel>.from(data.map((element) => PostModel.fromJson(element)));
}

PostModel postModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return PostModel.fromJson(data);
}

String postModelToJson(PostModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

Map<String, String> postModelToMap(PostModel data) {
  return {
    "img_detail": data.imgDetail,
    "caption": data.caption ?? '',
  };
}

class PostModel {
  PostModel({
    this.id,
    this.userId,
    this.postImg,
    required this.imgDetail,
    this.caption,
    this.likes,
    this.isLike,
    this.isSaved,
    this.updatedAt,
    this.createdAt,
  });

  int? id;
  int? userId;
  String? postImg;
  String imgDetail;
  String? caption;
  int? likes;
  bool? isLike;
  bool? isSaved;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json["id"],
    userId: json["user_id"],
    postImg: json["post_img"],
    imgDetail: json["img_detail"],
    caption: json["caption"],
    likes: json["likes"],
    isLike: json["is_like"],
    isSaved: json["is_saved"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "post_img": postImg,
    "img_detail": imgDetail,
    "caption": caption,
  };
}
