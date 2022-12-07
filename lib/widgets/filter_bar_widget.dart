import 'package:chom_tu/configs/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterBarWidget extends StatelessWidget {
  final String title;
  final bool status;

  const FilterBarWidget({Key? key, required this.title, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return status ?
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: Theme.of(context).textTheme.headline5),
          SizedBox(width: 5),
          SvgPicture.asset('assets/o4_up_1.svg', color: kColorsBlack),
        ],
      )
    : Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: Theme.of(context).textTheme.headline6),
          SizedBox(width: 5),
          SvgPicture.asset('assets/o4_down_1.svg', color: kColorsDarkGrey),
        ],
      );
  }
}