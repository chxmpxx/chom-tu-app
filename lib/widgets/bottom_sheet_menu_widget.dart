import 'package:chom_tu/configs/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class bottomSheetMenuWidget extends StatelessWidget {
  String icon;
  String title;
  void Function()? onTap;
  bottomSheetMenuWidget({Key? key, required this.icon, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: 22),
            Text(title, style: Theme.of(context).textTheme.headline2),
          ],
        ),
      ),
    );
  }
}