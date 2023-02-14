import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/admin/providers/admin_filter_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget adminChargesFilterTab(context) {
  var filterTab = Provider.of<AdminFilterTabProvider>(context, listen: false);

  return Consumer<AdminFilterTabProvider>(
    builder: (_, value, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              filterTab.selectCharges('Sort Lowest to Highest');
            },
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text('Sort Lowest to Highest', style: filterTab.charges == 'Sort Lowest to Highest' ? Theme.of(context).textTheme.headline5 : Theme.of(context).textTheme.headline6)
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
              filterTab.selectCharges('Sort Highest to Lowest');
            },
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text('Sort Highest to Lowest', style: filterTab.charges == 'Sort Highest to Lowest' ? Theme.of(context).textTheme.headline5 : Theme.of(context).textTheme.headline6)
            ),
          ),
        ],
      );
    }
  );
}