import 'package:chom_tu/configs/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterTabWidget extends StatelessWidget {
  final String title;

  const FilterTabWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: Theme.of(context).textTheme.headline3),
        SizedBox(width: 5),
        SvgPicture.asset('assets/o4_down_1.svg', color: kColorsGrey1),
      ],
    );
  }
}