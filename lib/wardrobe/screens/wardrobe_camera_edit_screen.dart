import 'dart:io';
import 'dart:typed_data';

import 'package:chom_tu/configs/themes/colors.dart';
import 'package:chom_tu/wardrobe/providers/wardrobe_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class WardrobeCameraEditScreen extends StatelessWidget {
  const WardrobeCameraEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var wardrobeProvider = Provider.of<WardrobeProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: kColorsWhite,
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(
            color: kColorsLightGrey,
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
          Padding(
            padding: const EdgeInsets.only(right: 22, top: 22),
            child: Text('Save', style: Theme.of(context).textTheme.headline5),
          ),
        ],
      ),
      bottomNavigationBar: cameraEditNavigationBar(context, wardrobeProvider),
      body: Center(
        child: Consumer<WardrobeProvider>(
          builder: (_, value, __) {
            return Container(
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

  Widget cameraEditNavigationBar(context, wardrobeProvider) {
    return Container(
      decoration: const BoxDecoration(
        color: kColorsWhite,
        border: Border(top: BorderSide(color: kColorsLightGrey, width: kAppbarBorderWidth))
      ),
      height: 75,
      width: MediaQuery.of(context).size.width,
      // color: kColorsWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () async {
              Navigator.pushNamed(context, '/wardrobe_edit_info');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/a3_info_1.svg'),
                const SizedBox(height: 5),
                const Text('  Info  ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kColorsBlack),),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              cropSquareImage(wardrobeProvider);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/b3_crop_1.svg'),
                const SizedBox(height: 5),
                const Text('  Crop  ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kColorsBlack),),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              Navigator.pushNamed(context, '/wardrobe_eraser');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/b3_eraser_1.svg', color: kColorsBlack),
                const SizedBox(height: 5),
                const Text('Eraser', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kColorsBlack),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<String> createFileFromString(Uint8List imageRemoveBg) async {
    Uint8List bytes = imageRemoveBg;
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File("$dir/${DateTime.now().millisecondsSinceEpoch}.png");
    await file.writeAsBytes(bytes);
    return file.path;
  }

  Future<void> cropSquareImage(wardrobeProvider) async {
    CroppedFile? cropImage = await ImageCropper().cropImage(
      sourcePath: wardrobeProvider.currentPath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      compressFormat: ImageCompressFormat.png,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: ' ',
          toolbarColor: kColorsBlack,
          toolbarWidgetColor: kColorsWhite,
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