import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/common_widgets/bottom_sheet_menu_widget.dart';
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
          BottomSheetMenuWidget(
            icon: 'assets/icons/a3_edit_1.svg',
            title: 'Edit Profile',
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile_edit');
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
            icon: 'assets/icons/o8_key_1.svg',
            title: 'Change Password',
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile_change_password');
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
            icon: 'assets/icons/o8_logout_1.svg',
            title: 'Log Out',
            onTap: (){
              // Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      );
    }
  );
}