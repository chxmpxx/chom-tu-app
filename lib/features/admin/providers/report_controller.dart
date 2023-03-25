import 'dart:convert';

import 'package:chom_tu/constants/api_constant.dart';
import 'package:chom_tu/features/admin/models/report_model.dart';
import 'package:http/http.dart' as http;

class ReportController {

  Future<String> addReport(data) async {
    final response = await http.post(Uri.parse("$reportURLAPI/add_report"), headers: await setHeaders(), body: json.encode(data));
    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Fail');
  }

  Future<List<ReportModel>> getAllReports(String sort, List<String> details, String status) async {
    var order = [["updatedAt", "DESC"]];
    if (sort == 'Oldest') {
      order = [["updatedAt", "ASC"]];
    }

    String data = jsonEncode({"order": order, "detail": details, "status": status});
    final response = await http.post(Uri.parse("$reportURLAPI/all_report"), headers: await setHeaders(), body: data);

    if (response.statusCode == 200) {
      return reportListModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<ReportModel> getOneReport(id) async {
    final response = await http.get(Uri.parse("$reportURLAPI/$id"), headers: await setHeaders());
    if (response.statusCode == 200) {
      return reportModelFromJson(response.body);
    }
    throw Exception('Fail');
  }

  Future<String> updateReport(id, Map<String, String> data) async {
    final response = await http.put(Uri.parse("$reportURLAPI/$id"), headers: await setHeaders(), body: json.encode(data));
    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Fail');
  }

  Future<String> deleteReport(id) async {
    final response = await http.delete(Uri.parse("$reportURLAPI/$id"), headers: await setHeaders());
    if (response.statusCode == 200) {
      return response.body;
    }
    throw Exception('Fail');
  }
}