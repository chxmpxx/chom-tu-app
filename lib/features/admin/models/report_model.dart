import 'dart:convert';

List<ReportModel> reportListModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<ReportModel>.from(data.map((element) => ReportModel.fromJson(element)));
}

ReportModel reportModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return ReportModel.fromJson(data);
}

String reportModelToJson(ReportModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

class ReportModel {
  ReportModel({
    this.id,
    required this.postId,
    this.postOwnerName,
    this.postImg,
    this.caption,
    this.reportedBy,
    this.reportedByName,
    required this.detail,
    required this.subDetail,
    this.status,
    this.updatedAt,
    this.createdAt,
  });

  int? id;
  int postId;
  String? postOwnerName;
  String? postImg;
  String? caption;
  int? reportedBy;
  String? reportedByName;
  String detail;
  String subDetail;
  String? status;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
    id: json["id"],
    postId: json["post_id"],
    postOwnerName: json["post_owner_name"] ?? '',
    postImg: json["post_img"] ?? '',
    caption: json["caption"] == '' ? '-' : json["caption"],
    reportedBy: json["reported_by"],
    reportedByName: json["reported_by_name"] ?? '',
    detail: json["detail"],
    subDetail: json["sub_detail"],
    status: json["status"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "post_id": postId,
    "detail": detail,
    "sub_detail": subDetail
  };
}
