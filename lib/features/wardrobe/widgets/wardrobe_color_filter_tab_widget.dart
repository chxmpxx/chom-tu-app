import 'package:chom_tu/constants/data_constant.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_filter_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

Widget wardrobeColorFilterTab(context) {
  var filterTab = Provider.of<WardrobeFilterTabProvider>(context, listen: false);
  
  return Stack(
    children: [
      Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          children: [
            Consumer<WardrobeFilterTabProvider>(
              builder: (_, value, __) {
                return Wrap(
                  runSpacing: 18,
                  spacing: 18,
                  children: [
                    ...List.generate(colors.length, (index) {
                        return InkWell(
                          onTap: (){
                            if(filterTab.colors.contains(colors[index])) {
                              filterTab.removeColors(colors[index]);
                            } else {
                              filterTab.addColors(colors[index]);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: filterTab.colors.contains(colors[index]) ? Border.all(color: kColorsBlack) : Border.all(color: kColorsLightGrey)
                            ),
                            child: Wrap(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: colorCodes[index],
                                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(color: kColorsLightGrey)
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(colors[index], style: filterTab.colors.contains(colors[index]) ? Theme.of(context).textTheme.bodyText1 : Theme.of(context).textTheme.caption)
                              ],
                            ),
                          ),
                        );
                      }
                    ),
                    InkWell(
                      onTap: (){
                        if(filterTab.colors.contains('Multi')) {
                          filterTab.removeColors('Multi');
                        } else {
                          filterTab.addColors('Multi');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: filterTab.colors.contains('Multi') ? Border.all(color: kColorsBlack) : Border.all(color: kColorsLightGrey)
                        ),
                        child: Wrap(
                          children: [
                            SvgPicture.asset('assets/icons/o9_multi_1.svg'),
                            const SizedBox(width: 5),
                            Text('Multi', style: filterTab.colors.contains('Multi') ? Theme.of(context).textTheme.bodyText1 : Theme.of(context).textTheme.caption)
                          ],
                        ),
                      ),
                    )
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
                filterTab.removeAllColors();
              },
              child: SvgPicture.asset('assets/icons/o9_bin_1.svg')
            ),
          ),
        ),
      ),
    ],
  );
}