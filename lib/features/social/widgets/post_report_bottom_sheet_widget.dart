import 'package:chom_tu/common_widgets/line_sheet_widget.dart';
import 'package:chom_tu/common_widgets/show_dialog_widget.dart';
import 'package:chom_tu/constants/data_constant.dart';
import 'package:chom_tu/features/admin/models/report_model.dart';
import 'package:chom_tu/features/admin/providers/report_controller.dart';
import 'package:flutter/material.dart';

Future<void> postReportBottomSheetWidget(BuildContext context, int postId) {
  return showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    context: context,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(child: Text('Report', style: Theme.of(context).textTheme.headline2)),
          ),

          ListView.builder(
            shrinkWrap: true,
            itemCount: reportDetail.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  lineSheetWidget(context),
                  InkWell(
                    onTap: (){
                      showDialogWidget(
                        context, 'Report Post', 'This post will be reported.', 'Report',
                        () async {
                          ReportModel data = ReportModel(postId: postId, detail: reportDetail[index], subDetail: reportSubDetail[index]);
                          await ReportController().addReport(data);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(reportDetail[index], style: Theme.of(context).textTheme.headline2),
                            const SizedBox(height: 7),
                            Text(reportSubDetail[index], style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
        ],
      );
    }
  );
}