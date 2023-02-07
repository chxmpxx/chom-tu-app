import 'package:chom_tu/constants/themes/colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String name;
  final void Function()? onTap;

  const ButtonWidget({Key? key, required this.name, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 34,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: kColorsBlack,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(name, style: Theme.of(context).textTheme.button)
          ),
        ),
      ),
    );
  }
}