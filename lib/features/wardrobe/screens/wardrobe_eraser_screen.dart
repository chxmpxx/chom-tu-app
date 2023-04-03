import 'dart:io';

import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/utils/remove_bg_api.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WardrobeEraserScreen extends StatelessWidget {
  const WardrobeEraserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var wardrobeProvider = Provider.of<WardrobeProvider>(context, listen: false);
    String imagePath;
    bool waitImage = true;

    Future<void> init() async {
      imagePath = await ApiClient().removeBgApi(wardrobeProvider.currentPath!);
      wardrobeProvider.isEditImage = true;
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
        backgroundColor: kColorsBlack,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/o1_false_1.svg', color: kColorsWhite),
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
            icon: SvgPicture.asset('assets/icons/o1_true_1.svg', color: kColorsWhite)
          )
        ],
      ),
      body: Center(
        child: Consumer<WardrobeProvider>(
          builder: (_, value, __) {
            return waitImage ? const CircularProgressIndicator()
            : Container(
              color: kColorsWhite,
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