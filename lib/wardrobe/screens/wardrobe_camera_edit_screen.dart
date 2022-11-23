import 'dart:io';
import 'dart:typed_data';

import 'package:chom_tu/configs/themes/colors.dart';
import 'package:chom_tu/utils/remove_bg_api.dart';
import 'package:chom_tu/wardrobe/providers/edit_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class WardrobeCameraEditScreen extends StatelessWidget {
  WardrobeCameraEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var wardrobeProvider = Provider.of<EditTabProvider>(context, listen: false);

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
      bottomNavigationBar: cameraEditNavigationBar(context, wardrobeProvider),
      body: Center(
        child: Consumer<EditTabProvider>(
          builder: (_, value, __) {
            return Container(
              color: kColorsGrey3,
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

  Widget cameraEditNavigationBar(context, wardrobeProvider) {
    return Container(
      decoration: BoxDecoration(
        color: kColorsWhite,
        border: Border(top: BorderSide(color: kColorsGrey2, width: kAppbarBorderWidth))
      ),
      height: 75,
      width: MediaQuery.of(context).size.width,
      // color: kColorsWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () async {
              cropSquareImage(wardrobeProvider);
            },
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
            onTap: () async {
              Navigator.pushNamed(context, '/wardrobe_eraser');
            },
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

  Future<String> createFileFromString(Uint8List ImageRemoveBg) async {
    Uint8List bytes = ImageRemoveBg;
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
      "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".png");
    await file.writeAsBytes(bytes);
    return file.path;
  }

  Future<void> cropSquareImage(wardrobeProvider) async {
    CroppedFile? cropImage = await ImageCropper().cropImage(
      sourcePath: wardrobeProvider.currentPath,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      compressFormat: ImageCompressFormat.png,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: ' ',
          toolbarColor: kColorsWhite,
          toolbarWidgetColor: kColorsBlack,
          initAspectRatio: CropAspectRatioPreset.original,
          activeControlsWidgetColor: kColorsRed,
          dimmedLayerColor: kColorsBlack,
          backgroundColor: kColorsBlack,
          lockAspectRatio: true,
          statusBarColor: kColorsWhite,
          // hideBottomControls: true
        ),
        IOSUiSettings(
          title: ' ',
        ),
      ],
    );
    if(cropImage != null) {
      wardrobeProvider.setPath(cropImage.path);
    }
  }
}