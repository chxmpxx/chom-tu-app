import 'package:chom_tu/common_widgets/show_dialog_widget.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/admin/models/report_model.dart';
import 'package:chom_tu/features/admin/providers/admin_provider.dart';
import 'package:chom_tu/features/admin/providers/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AdminReportInfoScreen extends StatelessWidget {
  const AdminReportInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var adminController = Provider.of<AdminProvider>(context, listen: false);
    var arg = (ModalRoute.of(context)?.settings.arguments ?? {"reportId" : -1, "postId": -1}) as Map<String, int>;
    var reportId = arg['reportId'];
    var postId = arg['postId'];

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
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/o3_back_1.svg', color: kColorsBlack),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: (){
              Map<String, String> data = { "status": 'Delete Post', "post_id": postId.toString(), "charges": adminController.charges };
              showDialogWidget(
                context, 'Delete Post', 'This post\'s report will be deleted.', 'Delete',
                () async {
                  await ReportController().updateReport(reportId, data);
                  Navigator.pushNamedAndRemoveUntil(context, '/admin_report', (route) => true);
                }
              );
            },
            icon: SvgPicture.asset('assets/icons/o9_bin_2.svg', color: kColorsBlack)
          ),
          IconButton(
            onPressed: (){
              Map<String, String> data = { "status": 'Discard Report', "charges": adminController.charges };
              showDialogWidget(
                context, 'Discard Report', 'This post\'s report will be discarded.', 'Discard',
                () async {
                  await ReportController().updateReport(reportId, data);
                  Navigator.pushNamedAndRemoveUntil(context, '/admin_report', (route) => true);
                }
              );
            },
            icon: SvgPicture.asset('assets/icons/o8_report_1.svg')
          ),
        ],
      ),
      body: FutureBuilder(
        future: ReportController().getOneReport(reportId),
        builder: (BuildContext context, AsyncSnapshot<ReportModel> snapshot) {
          if(snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          else if(snapshot.connectionState == ConnectionState.done) {
            ReportModel report = snapshot.data!;
            return reportInfoBody(context, report);
          }
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget reportInfoBody(context, ReportModel report) {
    return ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(report.postImg!),
                  fit: BoxFit.cover,
                ),
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Row(
                  children: [
                    SizedBox(
                      width: 96,
                      child: Text('Owner', style: Theme.of(context).textTheme.headline2)
                    ),
                    const SizedBox(width: 15),
                    Text(report.postOwnerName!, style: Theme.of(context).textTheme.headline5),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    SizedBox(
                      width: 96,
                      child: Text('Caption', style: Theme.of(context).textTheme.headline2)
                    ),
                    const SizedBox(width: 15),
                    Text(report.caption!, style: Theme.of(context).textTheme.headline5),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    SizedBox(
                      width: 96,
                      child: Text('Reported By', style: Theme.of(context).textTheme.headline2)
                    ),
                    const SizedBox(width: 15),
                    Text(report.reportedByName!, style: Theme.of(context).textTheme.headline5),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    SizedBox(
                      width: 96,
                      child: Text('Detail', style: Theme.of(context).textTheme.headline2)
                    ),
                    const SizedBox(width: 15),
                    Text(report.detail, style: Theme.of(context).textTheme.headline5),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const SizedBox(width: 111),
                    Text('(${report.subDetail})', style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          )
        ],
    );
  }

}