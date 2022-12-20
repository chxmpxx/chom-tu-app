import 'package:chom_tu/configs/themes/colors.dart';
import 'package:chom_tu/wardrobe/providers/wardrobe_filter_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

Widget wardrobeColorFilterTab(context) {
  var filterTab = Provider.of<WardrobeFilterTabProvider>(context, listen: false);

  List<String> colors = ['Brown', 'Yellow', 'Purple', 'Orange', 'Green', 'Pink', 'Blue', 'Red', 'White', 'Cream', 'Black', 'Gray'];
  List<Color> colorCodes = [kColorsBrown, kColorsYellow, kColorsPurple, kColorsOrange, kColorsGreen, kColorsPink, kColorsBlue, kColorsRed, kColorsWhite, kColorsCream, kColorsBlack, kColorsDarkGrey];

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
                            if(filterTab.color == colors[index]) {
                              filterTab.selectColor('None');
                            } else {
                              filterTab.selectColor(colors[index]);   
                            }          
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: filterTab.color == colors[index] ? Border.all(color: kColorsBlack) : Border.all(color: kColorsLightGrey)
                            ),
                            child: Wrap(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: colorCodes[index],
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(colors[index], style: filterTab.color == colors[index] ? Theme.of(context).textTheme.bodyText1 : Theme.of(context).textTheme.caption)
                              ],
                            ),
                          ),
                        );
                      }
                    ),
                    InkWell(
                      onTap: (){
                        if(filterTab.color == 'Multi') {
                          filterTab.selectColor('None');
                        } else {
                          filterTab.selectColor('Multi');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: filterTab.color == 'Multi' ? Border.all(color: kColorsBlack) : Border.all(color: kColorsLightGrey)
                        ),
                        child: Wrap(
                          children: [
                            SvgPicture.asset('assets/o9_multi_1.svg'),
                            const SizedBox(width: 5),
                            Text('Multi', style: filterTab.color == 'Multi' ? Theme.of(context).textTheme.bodyText1 : Theme.of(context).textTheme.caption)
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
                filterTab.selectColor('None');
              },
              child: SvgPicture.asset('assets/o9_bin_1.svg')
            ),
          ),
        ),
      ),
    ],
  );
}