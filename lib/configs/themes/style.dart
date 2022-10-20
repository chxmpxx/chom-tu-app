import 'package:chom_tu/configs/themes/constants.dart';
import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'Inter',
    
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 29.0, fontWeight: FontWeight.w700, color: kColorsBlack),
      headline2: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: kColorsBlack),
      headline3: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: kColorsGrey1),
      headline4: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: kColorsBlack),
      subtitle1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: kColorsBlack),
      subtitle2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: kColorsWhite),
      bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: kColorsBlack),
      bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kColorsWhite),
    ),

    iconTheme: IconThemeData(color: kColorsBlack)
  );
}