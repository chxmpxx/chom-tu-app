import 'package:chom_tu/configs/themes/colors.dart';
import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'Inter',
    
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 29.0, fontWeight: FontWeight.w700, color: kColorsBlack),

      headline2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: kColorsBlack),
      headline3: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: kColorsRed),
      headline4: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: kColorsWhite),
      headline5: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: kColorsBlack),
      headline6: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: kColorsDarkGrey),

      subtitle1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: kColorsBlack),

      subtitle2: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: kColorsBlack),
      bodyText1: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: kColorsBlack),
      bodyText2: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: kColorsWhite),

      button: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: kColorsWhite),
    ),

    iconTheme: IconThemeData(color: kColorsBlack)
  );
}