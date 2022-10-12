import 'package:chom_tu/configs/themes/constants.dart';
import 'package:flutter/material.dart';

class ColorBarWidget extends StatelessWidget {
  const ColorBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 24, width: MediaQuery.of(context).size.width, color: kColorsGrey2);
  }
}