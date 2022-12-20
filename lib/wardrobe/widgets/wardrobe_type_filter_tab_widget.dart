import 'package:chom_tu/configs/themes/colors.dart';
import 'package:chom_tu/wardrobe/providers/wardrobe_filter_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

Widget wardrobeTypeFilterTab(context) {
  var filterTab = Provider.of<WardrobeFilterTabProvider>(context, listen: false);
  List<String> types = ['Shirt', 'Turtleneck', 'Jacket', 'Waistcoat', 'Sweater'];

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
                    ...List.generate(types.length, (index) {
                        return InkWell(
                          onTap: (){
                            if(filterTab.type == types[index]) {
                              filterTab.selectType('None');
                            } else {
                              filterTab.selectType(types[index]);   
                            }          
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: filterTab.type == types[index] ? Border.all(color: kColorsBlack) : Border.all(color: kColorsLightGrey)
                            ),
                            child: Text(types[index], style: filterTab.type == types[index] ? Theme.of(context).textTheme.bodyText1 : Theme.of(context).textTheme.caption)
                          ),
                        );
                      }
                    ),
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
                filterTab.selectType('None');
              },
              child: SvgPicture.asset('assets/o9_bin_1.svg')
            ),
          ),
        ),
      ),
    ],
  );
}