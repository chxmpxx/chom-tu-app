import 'package:chom_tu/configs/themes/colors.dart';
import 'package:chom_tu/widgets/bottom_sheet_menu_widget.dart';
import 'package:flutter/material.dart';

Future<void> postBottomSheetWidget(BuildContext context) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    context: context,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          bottomSheetMenuWidget(
            icon: 'assets/a5_bookmark_1.svg',
            title: 'Save Post',
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
            icon: 'assets/o1_save_1.svg',
            title: 'Save Image',
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
            icon: 'assets/o8_report_1.svg',
            title: 'Repost',
            onTap: (){},
          ),
        ],
      );
    }
  );
}