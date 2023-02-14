import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/admin/providers/admin_filter_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget adminStatusFilterTab(context) {
  var filterTab = Provider.of<AdminFilterTabProvider>(context, listen: false);

  return Consumer<AdminFilterTabProvider>(
    builder: (_, value, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              filterTab.selectStatus('Active');
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