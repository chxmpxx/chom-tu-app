import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/outfit/providers/outfit_filter_tab_provider.dart';
import 'package:chom_tu/features/outfit/providers/outfit_tab_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget outfitSortFilterTab(context) {
  var filterTab = Provider.of<OutfitFilterTabProvider>(context, listen: false);
  var tabStatus = Provider.of<OutfitTabStatusProvider>(context, listen: false);

  return Consumer<OutfitFilterTabProvider>(
    builder: (_, value, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              filterTab.selectSort('Newest');
              tabStatus.tab(tabStatus.indexTab);
            },
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text('Newest', style: filterTab.sort == 'Newest' ? Theme.of(context).textTheme.headline5 : Theme.of(context).textTheme.headline6)
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
              filterTab.selectSort('Oldest');
              tabStatus.tab(tabStatus.indexTab);
            },
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text('Oldest', style: filterTab.sort == 'Oldest' ? Theme.of(context).textTheme.headline5 : Theme.of(context).textTheme.headline6)
            ),
          ),
        ],
      );
    }
  );
}