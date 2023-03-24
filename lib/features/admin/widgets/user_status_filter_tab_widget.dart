import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/admin/providers/admin_tab_status_provider.dart';
import 'package:chom_tu/features/admin/providers/admin_user_filter_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget userStatusFilterTab(context) {
  var filterTab = Provider.of<AdminUserFilterTabProvider>(context, listen: false);
  var tabStatus = Provider.of<AdminTabStatusProvider>(context, listen: false);

  return Consumer<AdminUserFilterTabProvider>(
    builder: (_, value, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              filterTab.selectStatus('Active');
              tabStatus.tab(tabStatus.indexTab);
            },
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text('Active', style: filterTab.status == 'Active' ? Theme.of(context).textTheme.headline5 : Theme.of(context).textTheme.headline6)
            ),
          ),
          Center(
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width - 36,
              color: kColorsLightGrey
            ),
          ),
          InkWell(
            onTap: (){
              filterTab.selectStatus('Banned');
              tabStatus.tab(tabStatus.indexTab);
            },
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text('Banned', style: filterTab.status == 'Banned' ? Theme.of(context).textTheme.headline5 : Theme.of(context).textTheme.headline6)
            ),
          ),
        ],
      );
    }
  );
}