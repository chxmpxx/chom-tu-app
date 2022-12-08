import 'package:chom_tu/configs/themes/colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  String name;
  void Function()? onTap;

  ButtonWidget({Key? key, required this.name, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 34,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: kColorsBlack,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(name, style: Theme.of(context).textTheme.button)
        ),
      ),
    );
  }
}