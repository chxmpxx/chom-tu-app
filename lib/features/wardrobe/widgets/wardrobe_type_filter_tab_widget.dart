import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/constants/data_constant.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_filter_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

Widget wardrobeTypeFilterTab(context) {
  var filterTab = Provider.of<WardrobeFilterTabProvider>(context, listen: false);

  List<String> types = [];

  if (filterTab.category == 'Top') {
    types = topTypes;
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
                return  Wrap(
                  runSpacing: 18,
                  spacing: 18,
                  children: [
                    ...List.generate(types.length, (index) {
                      return InkWell(
                        onTap: (){
                          if(filterTab.types.contains(types[index])) {
                            filterTab.removeTypes(types[index]);
                          } else {
                            filterTab.addTypes(types[index]);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: filterTab.types.contains(types[index]) ? Border.all(color: kColorsBlack) : Border.all(color: kColorsLightGrey)
                          ),
                          child: Text(types[index], style: filterTab.types.contains(types[index]) ? Theme.of(context).textTheme.bodyText1 : Theme.of(context).textTheme.caption)
                        ),
                      );
                    }),
                  ],
                );
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
                    filterBtn(filterTab, bottomSkirtsTypes, context, 'skirts'),
                    const SizedBox(height: 18),

                    const Text('Shorts', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: kColorsDarkGrey)),
                    const SizedBox(height: 18),
                    filterBtn(filterTab, bottomShortsTypes, context, 'shorts'),
                    const SizedBox(height: 18),

                    const Text('Trousers', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: kColorsDarkGrey)),
                    const SizedBox(height: 18),
                    filterBtn(filterTab, bottomTrousersTypes, context, 'trousers')
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
                filterTab.category != 'Bottom' ? filterTab.removeAllTypes() : filterTab.removeAllBottomTypes();
              },
              child: SvgPicture.asset('assets/icons/o9_bin_1.svg')
            ),
          ),
        ),
      ),
    ],
  );
}

Widget filterBtn(WardrobeFilterTabProvider filterTab, List<String> list, context, String key) {
  return Wrap(
    runSpacing: 18,
    spacing: 18,
    children: [
      ...List.generate(list.length, (index) {
        return InkWell(
          onTap: (){
            if(filterTab.bottomTypes[key]!.contains(list[index])) {
              filterTab.removeBottomTypes(key, list[index]);
            } else {
              filterTab.addBottomTypes(key, list[index]);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: filterTab.bottomTypes[key]!.contains(list[index]) ? Border.all(color: kColorsBlack) : Border.all(color: kColorsLightGrey)
            ),
            child: Text(list[index], style: filterTab.bottomTypes[key]!.contains(list[index]) ? Theme.of(context).textTheme.bodyText1 : Theme.of(context).textTheme.caption)
          ),
        );
      }),
    ],
  );
}