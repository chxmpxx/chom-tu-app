import 'package:chom_tu/configs/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;

  const PanelWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      itemCount: 20,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1
      ),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 1, right: 1, bottom: 2),
          child: InkWell(
            onTap: (){},
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: kColorsGrey3
              ),
            ),
          ),
        );
      }
    );
  }
}