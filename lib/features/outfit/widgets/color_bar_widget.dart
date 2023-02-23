import 'package:chom_tu/constants/data_constant.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/outfit/providers/outfit_create_provider.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_filter_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ColorBarWidget extends StatelessWidget {
  final OutfitCreateProvider outfitProvider;
  const ColorBarWidget({Key? key, required this.outfitProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var filterTab = Provider.of<WardrobeFilterTabProvider>(context, listen: false);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 24,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...List.generate(colors.length, (index) {
            return InkWell(
              onTap: (){
                if(filterTab.colors.contains(colors[index])) {
                  filterTab.removeColors(colors[index]);
                } else {
                  filterTab.addColors(colors[index]);
                }
                print('>>>>>> ${filterTab.colors}');
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  alignment: Alignment.center,
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    color: filterTab.colors.contains(colors[index]) ? colorCodes[index].withOpacity(0) : colorCodes[index],
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    border: Border.all(color: filterTab.colors.contains(colors[index]) ? kColorsBlack : kColorsLightGrey)
                  ),
                  child: filterTab.colors.contains(colors[index]) ? Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      color: colorCodes[index],
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      border: Border.all(color: kColorsLightGrey)
                    ),
                  ) : Container()
                ),
              ),
            );
          }),
          InkWell(
            onTap: (){
              if(filterTab.colors.contains('Multi')) {
                filterTab.removeColors('Multi');
              } else {
                filterTab.addColors('Multi');
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                alignment: Alignment.center,
                height: 24,
                width: 24,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24))
                ),
                child: filterTab.colors.contains('Multi') ? SvgPicture.asset('assets/icons/o9_multi_3.svg') : SvgPicture.asset('assets/icons/o9_multi_2.svg'),
              ),
            )
          )
        ]
      )
    );
  }
}