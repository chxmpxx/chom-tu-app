import 'dart:io';

import 'package:chom_tu/configs/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WardrobeCameraEditScreen extends StatelessWidget {
  final String path;
  final bool isGallery;
  const WardrobeCameraEditScreen({Key? key, required this.path, required this.isGallery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorsWhite,
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: kColorsGrey2,
            width: kAppbarBorderWidth
          )
        ),
        elevation: 0,
        toolbarHeight: 60,
        centerTitle: true,
        title: Text('Edit', style: Theme.of(context).textTheme.headline1),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        leading: IconButton(
          icon: SvgPicture.asset('assets/o3_back_1.svg', color: kColorsBlack),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset('assets/o1_save_1.svg', color: kColorsBlack)
          ),
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset('assets/o1_true_1.svg', color: kColorsBlack)
          )
        ],
      ),
      bottomNavigationBar: cameraEditNavigationBar(context),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Image.file(
            File(path),
            fit: isGallery ? BoxFit.cover : BoxFit.fill,
          )
        ),
      )
    );
  }

  Widget cameraEditNavigationBar(context) {
    return Container(
      height: 75,
      width: MediaQuery.of(context).size.width,
      color: kColorsWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: (){},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/b3_crop_1.svg'),
                SizedBox(height: 5),
                Text('  Crop  ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kColorsBlack),),
              ],
            ),
          ),
          InkWell(
            onTap: (){},
            child: SvgPicture.asset('assets/b3_shot_confirm_1.svg')
          ),
          InkWell(
            onTap: (){},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/b3_eraser_1.svg', color: kColorsBlack),
                SizedBox(height: 5),
                Text('Eraser', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kColorsBlack),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}