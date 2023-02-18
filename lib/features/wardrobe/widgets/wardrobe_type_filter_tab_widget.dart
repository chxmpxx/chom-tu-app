import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/constants/data_constant.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_filter_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

Widget wardrobeTypeFilterTab(context) {
  var filterTab = Provider.of<WardrobeFilterTabProvider>(context, listen: false);

  List<String> types = [];
  List<String> shortsTypes = [];
  List<String> trousersTypes = [];
  List<String> skirtsTypes = [];

  if (filterTab.category == 'Top') {
    types = topTypes;
  } else if (filterTab.category == 'Bottom') {
    skirtsTypes = bottomSkirtsTypes;
    shortsTypes = bottomShortsTypes;
    trousersTypes = bottomTrousersTypes;
  } else if (filterTab.category == 'Set') {
    types = setTypes;
  } else if (filterTab.category == 'Shoes') {
    types = shoesTypes;
  } else if (filterTab.category == 'Accessory') {
    types = accessoryTypes;
  }


  return Stack(
    children: [
      filterTab.category != 'Bottom' ?
      Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          children: [
            Consumer<WardrobeFilterTabProvider>(
              builder: (_, value, __) {
                return filterBtn(filterTab, types, context, '');
              }
            ),
            const SizedBox(height: 40)
          ],
        ),
      )

      // Bottom
      : Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          children: [
            Consumer<WardrobeFilterTabProvider>(
              builder: (_, value, __) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Skirts', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: kColorsDarkGrey)),
                    const SizedBox(height: 18),
                    filterBtn(filterTab, skirtsTypes, context, 'Skirts '),
                    const SizedBox(height: 18),

                    const Text('Shorts', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: kColorsDarkGrey)),
                    const SizedBox(height: 18),
                    filterBtn(filterTab, shortsTypes, context, 'Shorts '),
                    const SizedBox(height: 18),

                    const Text('Trousers', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: kColorsDarkGrey)),
                    const SizedBox(height: 18),
                    filterBtn(filterTab, trousersTypes, context, 'Trousers ')
                  ],
                );
              }
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),

      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Container(
            alignment: Alignment.bottomRight,
            width: MediaQuery.of(context).size.width,
            height: 40,
            color: kColorsWhite,
            child: InkWell(
              onTap: (){
                filterTab.removeAllTypes();
              },
              child: SvgPicture.asset('assets/icons/o9_bin_1.svg')
            ),
          ),
        ),
      ),
    ],
  );
}

Widget filterBtn(WardrobeFilterTabProvider filterTab, List<String> list, context, String bottomName) {
  //todo: concat bottom type
  return Wrap(
    runSpacing: 18,
    spacing: 18,
    children: [
      ...List.generate(list.length, (index) {
        return InkWell(
          onTap: (){
            if(filterTab.types.contains('$bottomName${list[index]}')) {
              filterTab.removeTypes('$bottomName${list[index]}');
            } else {
              filterTab.addTypes('$bottomName${list[index]}');
            }
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: filterTab.types.contains('$bottomName${list[index]}') ? Border.all(color: kColorsBlack) : Border.all(color: kColorsLightGrey)
            ),
            child: Text(list[index], style: filterTab.types.contains('$bottomName${list[index]}') ? Theme.of(context).textTheme.bodyText1 : Theme.of(context).textTheme.caption)
          ),
        );
      }),
    ],
  );
}