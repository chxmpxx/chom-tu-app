import 'package:chom_tu/configs/themes/colors.dart';
import 'package:chom_tu/outfit/providers/outfit_filter_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

Widget outfitStyleFilterTab(context) {
  var filterTab = Provider.of<OutfitFilterTabProvider>(context, listen: false);
  List<String> styles = ['Y2K', 'Cute', 'Decora', 'E-girl', 'Fairy', 'Party', 'Sexy', 'Vintage', 'Punk', 'Sporty', 'Winter', 'Minimal'];

  return Stack(
    children: [
      Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          children: [
            Consumer<OutfitFilterTabProvider>(
              builder: (_, value, __) {
                return Wrap(
                  runSpacing: 18,
                  spacing: 18,
                  children: [
                    ...List.generate(styles.length, (index) {
                        return InkWell(
                          onTap: (){
                            if(filterTab.style == styles[index]) {
                              filterTab.selectStyle('None');
                            } else {
                              filterTab.selectStyle(styles[index]);   
                            }          
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: filterTab.style == styles[index] ? Border.all(color: kColorsBlack) : Border.all(color: kColorsLightGrey)
                            ),
                            child: Text(styles[index], style: filterTab.style == styles[index] ? Theme.of(context).textTheme.bodyText1 : Theme.of(context).textTheme.caption)
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
                filterTab.selectStyle('None');
              },
              child: SvgPicture.asset('assets/o9_bin_1.svg')
            ),
          ),
        ),
      ),
    ],
  );
}