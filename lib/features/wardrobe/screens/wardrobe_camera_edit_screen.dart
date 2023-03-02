import 'dart:io';

import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/dashboard/dashboard_provider.dart';
import 'package:chom_tu/features/wardrobe/models/wardrobe_model.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_controller.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_provider.dart';
import 'package:chom_tu/utils/create_file_from_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';

class WardrobeCameraEditScreen extends StatelessWidget {
  const WardrobeCameraEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arg = (ModalRoute.of(context)?.settings.arguments ?? {"id" : '-1'}) as Map<String, dynamic>;
    final wardrobeId = arg["id"];

    var wardrobeProvider = Provider.of<WardrobeProvider>(context, listen: false);
    var dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    WardrobeModel data;

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
          icon: SvgPicture.asset('assets/icons/o3_back_1.svg', color: kColorsBlack),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22, top: 22),
            child: InkWell(
              onTap: () async {
                data = WardrobeModel(userId: 2, category: wardrobeProvider.category, subCategory: wardrobeProvider.subCategory, color: wardrobeProvider.color, type: wardrobeProvider.type);

                if (wardrobeId == '-1') {
                  // new wardrobe (add)
                  await WardrobeController().addWardrobe(data, wardrobeProvider.currentPath);
                  dashboardProvider.setCurrentIndex(0);
                  Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => true);
                } else {
                  // edit wardrobe (update)
                  if (wardrobeProvider.isEditImage == false) {
                    // if isEditImage = false -> don't change image in firebase
                    await WardrobeController().updateWardrobe(wardrobeId, data);
                  } else {
                    await WardrobeController().updateWardrobe(wardrobeId, data, wardrobeProvider.currentPath);
                  }
                  wardrobeProvider.isEditImage = false;
                  Navigator.pushNamedAndRemoveUntil(context, '/wardrobe_info', (route) => true, arguments: {"id": wardrobeId, "route": arg["route"]});
                }
              },
              child: Text('Save', style: Theme.of(context).textTheme.headline5)
            ),
          ),
        ],
      ),
      bottomNavigationBar: cameraEditNavigationBar(context, wardrobeProvider, wardrobeId, arg),
      body: Center(
        child: Consumer<WardrobeProvider>(
          builder: (_, value, __) {
            return AspectRatio(
              aspectRatio: 1,
              child: SizedBox(
                width: double.infinity,
                child: wardrobeId == '-1' || wardrobeProvider.isEditImage == true ?
                  Image.file(File(wardrobeProvider.currentPath!), fit: wardrobeProvider.isGallery ? BoxFit.cover : BoxFit.fill)
                  : Image.network(wardrobeProvider.image!, fit: BoxFit.cover)
              )
            );
          }
        )
      )
    );
  }

  Widget cameraEditNavigationBar(context, wardrobeProvider, wardrobeId, arg) {
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
              Navigator.pushNamed(context, '/wardrobe_edit_info', arguments: {'id': wardrobeId, 'route': arg["route"]});
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/a3_info_1.svg'),
                const SizedBox(height: 5),
                const Text('  Info  ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kColorsBlack),),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              cropSquareImage(wardrobeProvider, wardrobeId);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/b3_crop_1.svg'),
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
                SvgPicture.asset('assets/icons/b3_eraser_1.svg', color: kColorsBlack),
                const SizedBox(height: 5),
                const Text('Eraser', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kColorsBlack),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> cropSquareImage(WardrobeProvider wardrobeProvider, wardrobeId) async {
    if (wardrobeId != '-1') {
      wardrobeProvider.currentPath = await createFileFromUrl(wardrobeProvider.image!);
    }

    CroppedFile? cropImage = await ImageCropper().cropImage(
      sourcePath:  wardrobeProvider.currentPath!,
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
      wardrobeProvider.isEditImage = true;
      wardrobeProvider.setPath(cropImage.path);
    }
  }
}