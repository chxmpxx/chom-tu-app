import 'package:chom_tu/utils/create_file_from_string.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  Future<String> removeBgApi(String imagePath) async {
    var request = http.MultipartRequest(
      "POST", Uri.parse("https://api.remove.bg/v1.0/removebg")
    );
    request.files.add(await http.MultipartFile.fromPath("image_file", imagePath));
    request.headers.addAll({"X-API-Key": "pUAz6du8fUzuZ6DeRZkx941V"});
    final response = await request.send();
    if (response.statusCode == 200) {
      http.Response imgRes = await http.Response.fromStream(response);
      String imagePath = await createFileFromString(imgRes.bodyBytes);
      return imagePath;
    } else {
      throw Exception("Error occurred with response ${response.statusCode}");
    }
  }
}