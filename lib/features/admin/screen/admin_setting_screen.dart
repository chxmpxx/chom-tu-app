import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/admin/widgets/admin_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminSettingScreen extends StatelessWidget {
  const AdminSettingScreen({super.key});

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
        title: Text('Setting', style: Theme.of(context).textTheme.subtitle1),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        leading: Builder(
          builder: (context) => IconButton(
            icon: SvgPicture.asset('assets/icons/a1_hamburger_1.svg', color: kColorsBlack),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {},
            icon: SvgPicture.asset('assets/icons/a3_edit_1.svg')
          )
        ],
      ),
      drawer: adminDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Maximum Charges', style: Theme.of(context).textTheme.headline2),
                    Text('50', style: Theme.of(context).textTheme.headline5),
                  ],
                ),
                const SizedBox(height: 10),
                Text('Total charge until user got banned', style: Theme.of(context).textTheme.bodyText1),
              ],
            )
          ],
        ),
      ),
    );
  }
}