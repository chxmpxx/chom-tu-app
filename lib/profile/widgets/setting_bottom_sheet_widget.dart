import 'package:chom_tu/configs/themes/colors.dart';
import 'package:chom_tu/widgets/bottom_sheet_menu_widget.dart';
import 'package:flutter/material.dart';

Future<void> settingBottomSheetWidget(BuildContext context) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    context: context,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          bottomSheetMenuWidget(
            icon: 'assets/a3_edit_1.svg',
            color: kColorsBlack,
            title: 'Edit Profile',
            onTap: (){},
          ),
          Center(
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width - 44,
              color: kColorsLightGrey
            ),
          ),
          bottomSheetMenuWidget(
            icon: 'assets/o8_key_1.svg',
            color: kColorsBlack,
            title: 'Change Password',
            onTap: (){},
          ),
          Center(
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width - 44,
              color: kColorsLightGrey
            ),
          ),
          bottomSheetMenuWidget(
            icon: 'assets/o8_logout_1.svg',
            color: kColorsBlack,
            title: 'Log Out',
            onTap: (){},
          ),
        ],
      );
    }
  );
}