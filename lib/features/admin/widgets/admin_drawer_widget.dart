import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/admin/providers/admin_provider.dart';
import 'package:chom_tu/features/admin/providers/admin_report_filter_tab_provider.dart';
import 'package:chom_tu/features/admin/providers/admin_user_filter_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

Widget adminDrawer(context) {
  var adminController = Provider.of<AdminProvider>(context, listen: false);
  var adminUserFilterTab = Provider.of<AdminUserFilterTabProvider>(context, listen: false);
  var adminReportFilterTab = Provider.of<AdminReportFilterTabProvider>(context, listen: false);

  List<String> list = ['User', 'Report', 'History', 'Setting', 'Log Out'];
  List<String> iconList = ['b1_profile_1.svg', 'o8_report_1.svg', 'o8_history_1.svg', 'a5_setting_1.svg', 'o8_logout_1.svg'];
  List<String> screens = ['/admin_user', '/admin_report', '/admin_history', '/admin_setting', '/login'];

  return Drawer(
    width: MediaQuery.of(context).size.width * 0.67,
    child: Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Ink(
        color: kColorsWhite,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 34),
                    child: Text('Menu', style: Theme.of(context).textTheme.subtitle1),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: SvgPicture.asset('assets/icons/o1_false_1.svg', color: kColorsBlack)
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                ...List.generate(list.length, (index) {
                  return ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: list[index] != 'Log Out' ? 
                        SvgPicture.asset('assets/icons/${iconList[index]}', color: adminController.menu == list[index] ? kColorsWhite : kColorsBlack)
                        : adminController.menu != 'Log Out' ? SvgPicture.asset('assets/icons/o8_logout_1.svg') : SvgPicture.asset('assets/icons/o8_logout_2.svg'),
                    ),
                    title: Text(list[index], style: adminController.menu == list[index] ? Theme.of(context).textTheme.headline4 : Theme.of(context).textTheme.headline5),
                    tileColor: adminController.menu == list[index] ? kColorsBlack : kColorsWhite,
                    onTap: (){
                      adminUserFilterTab.removeAllFilterTab();
                      adminReportFilterTab.removeAllFilterTab();
                      adminController.setMenu(list[index]);
                      Navigator.pushReplacementNamed(context, screens[index]);
                      // Navigator.pushNamedAndRemoveUntil(context, screens[index], (route) => false);
                    },
                  );
                })
              ]
            )
          ],
        ),
      ),
    ),
  );
}