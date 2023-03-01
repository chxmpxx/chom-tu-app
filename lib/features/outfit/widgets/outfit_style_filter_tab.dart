import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/outfit/providers/outfit_filter_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

Widget outfitStyleFilterTab(context, styles) {
  var filterTab = Provider.of<OutfitFilterTabProvider>(context, listen: false);

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
                            if(filterTab.styles.contains(styles[index])) {
                              filterTab.removeStyle(styles[index]);
                            } else {
                              filterTab.addStyle(styles[index]);
                            }        
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: filterTab.styles.contains(styles[index]) ? Border.all(color: kColorsBlack) : Border.all(color: kColorsLightGrey)
                            ),
                            child: Text(styles[index], style: filterTab.styles.contains(styles[index]) ? Theme.of(context).textTheme.bodyText1 : Theme.of(context).textTheme.caption)
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
                filterTab.removeAllStyle();
              },
              child: SvgPicture.asset('assets/icons/o9_bin_1.svg')
            ),
          ),
        ),
      ),
    ],
  );
}

  // FutureBuilder(
  //   future: OutfitController().getStyle(2),
  //   builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
  //     if(snapshot.hasError) {
  //       return Center(
  //         child: Text(snapshot.error.toString()),
  //       );
  //     }
  //     else if(snapshot.connectionState == ConnectionState.done) {
  //       List<String> styles = snapshot.data!;
  //       return body(styles, context);
  //     }
  //     else {
  //       return const Center(
  //         child: CircularProgressIndicator(),
  //       );
  //     }
  //   },
  // );