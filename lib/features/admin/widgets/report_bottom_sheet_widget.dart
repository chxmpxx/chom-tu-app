import 'package:chom_tu/common_widgets/show_dialog_widget.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/common_widgets/bottom_sheet_menu_widget.dart';
import 'package:chom_tu/features/admin/providers/admin_provider.dart';
import 'package:chom_tu/features/admin/providers/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> reportBottomSheetWidget(BuildContext context, int reportId, int postId) {
  var adminController = Provider.of<AdminProvider>(context, listen: false);

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
              Navigator.pop(context);
              Navigator.pushNamed(context, '/admin_report_info', arguments: {"reportId" : reportId, "postId": postId});
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
              Map<String, String> data = { "status": 'Discard Report', "charges": adminController.charges };
              showDialogWidget(
                context, 'Discard Report', 'This post\'s report will be discarded.', 'Discard',
                () async {
                  await ReportController().updateReport(reportId, data);
                  Navigator.pushNamedAndRemoveUntil(context, '/admin_report', (route) => true);
                }
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
              Map<String, String> data = { "status": 'Delete Post', "post_id": postId.toString(), "charges": adminController.charges };
              showDialogWidget(
                context, 'Delete Post', 'This post\'s report will be deleted.', 'Delete',
                () async {
                  await ReportController().updateReport(reportId, data);
                  Navigator.pushNamedAndRemoveUntil(context, '/admin_report', (route) => true);
                }
              );
            },
            color: 'red'
          ),
        ],
      );
    }
  );
}