import 'package:chom_tu/constants/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomSheetMenuWidget extends StatelessWidget {
  final String icon;
  final String title;
  final void Function()? onTap;
  String color;
  BottomSheetMenuWidget({Key? key, required this.icon, required this.title, required this.onTap, this.color = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Row(
          children: [
            SvgPicture.asset(icon, color: color == 'black' ? kColorsBlack : null),
            const SizedBox(width: 22),
            color != 'red' ? Text(title, style: Theme.of(context).textTheme.headline2) : Text(title, style: Theme.of(context).textTheme.headline3)
          ],
        ),
      ),
    );
  }
}