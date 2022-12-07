import 'dart:io';

import 'package:chom_tu/configs/themes/colors.dart';
import 'package:chom_tu/utils/remove_bg_api.dart';
import 'package:chom_tu/wardrobe/providers/wardrobe_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WardrobeEraserScreen extends StatelessWidget {
  const WardrobeEraserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var wardrobeProvider = Provider.of<WardrobeImageProvider>(context, listen: false);
    String imagePath;
    bool waitImage = true;

    Future<void> init() async {
      imagePath = await ApiClient().removeBgApi(wardrobeProvider.currentPath!);
      wardrobeProvider.setPath(imagePath);
      waitImage = false;
    }

    init();
    return Scaffold(
      backgroundColor: kColorsBlack,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        leading: IconButton(
          icon: SvgPicture.asset('assets/o1_false_1.svg', color: kColorsBlack),
          onPressed: (){
            wardrobeProvider.setPath(wardrobeProvider.previousPath!);
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/o1_true_1.svg', color: kColorsBlack)
          )
        ],
      ),
      body: Center(
        child: Consumer<WardrobeImageProvider>(
          builder: (_, value, __) {
            return waitImage ? CircularProgressIndicator()
            : Container(
              color: kColorsGrey,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: Image.file(
                File(wardrobeProvider.currentPath!),
                fit: wardrobeProvider.isGallery ? BoxFit.cover : BoxFit.fill,
              )
            );
          }
        )
      )
    );
  }
}