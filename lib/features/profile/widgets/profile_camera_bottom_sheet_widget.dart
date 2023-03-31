import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/common_widgets/bottom_sheet_menu_widget.dart';
import 'package:chom_tu/features/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

Future<void> profileCameraBottomSheetWidget(BuildContext context) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    context: context,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          BottomSheetMenuWidget(
            icon: 'assets/icons/b2_gallery_1.svg',
            title: 'Choose From Album',
            color: 'black',
            onTap: (){
              Navigator.pop(context);
              openGallery(context);
            },
          ),
          Center(
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width - 44,
              color: kColorsLightGrey
            ),
          ),
          BottomSheetMenuWidget(
            icon: 'assets/icons/a1_camera_1.svg',
            title: 'Take Photo',
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile_camera');
            },
          )
        ],
      );
    }
  );
}

void openGallery(BuildContext context) async {
  var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if(pickedFile != null) {
    profileProvider.setProfileImg(pickedFile.path);
  }
}