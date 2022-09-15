import 'package:chom_tu/configs/themes/color.dart';
import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'Inter',
    
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 29.0, fontWeight: FontWeight.w700, color: kColorsBlack),
      headline2: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: kColorsBlack),
      subtitle1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: kColorsBlack),
      subtitle2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: kColorsWhite),
      bodyText1: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: kColorsBlack),
    ),

    iconTheme: IconThemeData(color: kColorsBlack)
  );
}