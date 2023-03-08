import 'package:chom_tu/constants/themes/colors.dart';
import 'package:flutter/material.dart';

Widget lineSheetWidget(context) {
  return Center(
    child: Container(
      height: 1,
      width: MediaQuery.of(context).size.width - 44,
      color: kColorsLightGrey
    ),
  );
}