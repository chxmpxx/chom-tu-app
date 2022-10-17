import 'package:chom_tu/configs/themes/constants.dart';
import 'package:chom_tu/outfit/providers/outfit_create_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;

  const PanelWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<OutfitCreateProvider>(context, listen: false);
    List imageList = ["assets/1.png", "assets/2.png", "assets/3.png", "assets/4.png", "assets/5.png", "assets/6.png"];

    return GridView.builder(
      controller: controller,
      itemCount: imageList.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1
      ),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 1, right: 1, bottom: 2),
          child: InkWell(
            onTap: (){
              provider.SelectTop(imageList[index]);
            },
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageList[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}