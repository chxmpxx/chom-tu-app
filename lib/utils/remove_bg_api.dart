import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ApiClient {
  Future<String> removeBgApi(String imagePath) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("https://api.remove.bg/v1.0/removebg"));
    request.files
        .add(await http.MultipartFile.fromPath("image_file", imagePath));
    request.headers.addAll({"X-API-Key": "b3Ucz5DUhC4g8dWQBjwquNyP"});
    final response = await request.send();
    if (response.statusCode == 200) {
      http.Response imgRes = await http.Response.fromStream(response);
      String imagePath = await createFileFromString(imgRes.bodyBytes);
      return imagePath;
    } else {
      throw Exception("Error occurred with response ${response.statusCode}");
    }
  }

  Future<String> createFileFromString(Uint8List ImageRemoveBg) async {
    Uint8List bytes = ImageRemoveBg;
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
      "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".png");
    await file.writeAsBytes(bytes);
    return file.path;
  }
}