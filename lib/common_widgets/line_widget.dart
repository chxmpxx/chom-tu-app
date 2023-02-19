import 'package:chom_tu/constants/themes/colors.dart';
import 'package:flutter/material.dart';

Widget line(context) {
  return Container(
    height: kAppbarBorderWidth,
    width: MediaQuery.of(context).size.width,
    color: kColorsLightGrey,
  );
}