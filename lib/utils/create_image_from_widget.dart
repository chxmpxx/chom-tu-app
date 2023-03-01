import 'package:chom_tu/utils/create_file_from_string.dart';
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

Future<String> convertWidgetToImage(key) async {
  RenderRepaintBoundary renderRepaintBoundary = key.currentContext.findRenderObject();
  ui.Image boxImage = await renderRepaintBoundary.toImage(pixelRatio: 1);
  ByteData byteData = await boxImage.toByteData(format: ui.ImageByteFormat.png) as ByteData;
  Uint8List uint8list = byteData.buffer.asUint8List();
  return createFileFromString(uint8list);
}