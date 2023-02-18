import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<String> createFileFromString(Uint8List imageRemoveBg) async {
  Uint8List bytes = imageRemoveBg;
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = File("$dir/${DateTime.now().millisecondsSinceEpoch}.png");
  await file.writeAsBytes(bytes);
  return file.path;
}