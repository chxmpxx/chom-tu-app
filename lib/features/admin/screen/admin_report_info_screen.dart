import 'package:chom_tu/common_widgets/show_dialog_widget.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminReportInfoScreen extends StatelessWidget {
  const AdminReportInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              showDialogWidget(
                context, 'Delete Post', 'This post\'s report will be deleted.', 'Delete',
                (){}
              );
            },
            icon: SvgPicture.asset('assets/icons/o9_bin_2.svg', color: kColorsBlack)
          ),
          IconButton(
            onPressed: (){
              showDialogWidget(
                context, 'Discard Report', 'This post\'s report will be discarded.', 'Discard',
                (){}
              );
            },
            icon: SvgPicture.asset('assets/icons/o8_report_1.svg')
          ),
        ],
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: kColorsGrey
              ),
            ),
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
                    Text('Nong._', style: Theme.of(context).textTheme.headline5),
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
                    Text('>> Link: www.haha.xxx', style: Theme.of(context).textTheme.headline5),
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
                    Text('Suki.Desu', style: Theme.of(context).textTheme.headline5),
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
                    Text('Spam', style: Theme.of(context).textTheme.headline5),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const SizedBox(width: 111),
                    Text('(Misleading or repetitive posts)', style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          )
        ],
      )
    );
  }
}