import 'package:chom_tu/common_widgets/show_dialog_widget.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/common_widgets/bottom_sheet_menu_widget.dart';
import 'package:flutter/material.dart';

Future<void> reportBottomSheetWidget(BuildContext context) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    context: context,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          BottomSheetMenuWidget(
            icon: 'assets/icons/a3_info_1.svg',
            title: 'Information',
            onTap: (){
              Navigator.pushNamed(context, '/admin_report_info');
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
            icon: 'assets/icons/o8_report_1.svg',
            title: 'Discard Report',
            onTap: (){
              Navigator.pop(context);
              showDialogWidget(
                context, 'Discard Report', 'This post\'s report will be discarded.', 'Discard',
                (){}
              );
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
            icon: 'assets/icons/o9_bin_2.svg',
            title: 'Delete Post',
            onTap: (){
              Navigator.pop(context);
              showDialogWidget(
                context, 'Delete Post', 'This post\'s report will be deleted.', 'Delete',
                (){}
              );
            },
            color: 'red'
          ),
        ],
      );
    }
  );
}