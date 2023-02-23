import 'package:chom_tu/constants/data_constant.dart';
import 'package:chom_tu/features/outfit/providers/outfit_create_provider.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_filter_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypeBarWidget extends StatelessWidget {
  final OutfitCreateProvider outfitProvider;
  const TypeBarWidget({Key? key, required this.outfitProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var filterTab = Provider.of<WardrobeFilterTabProvider>(context, listen: false);

    List<List<String>> typeList = [[], topTypes, bottomTypes, setTypes, shoesTypes, accessoryTypes];
    List<List<String>> bottomList = [bottomSkirtsTypes, bottomShortsTypes, bottomTrousersTypes];
    List<String> types = outfitProvider.outfitIndex != 2 ? typeList[outfitProvider.outfitIndex] : bottomList[outfitProvider.bottomIndex];

    List<String> bottomKey = ['skirts', 'shorts', 'trousers'];
    String key = bottomKey[outfitProvider.bottomIndex];

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 30,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...List.generate(types.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: (){
                  if (outfitProvider.outfitIndex != 2) {
                    if (filterTab.types.contains(types[index])) {
                      filterTab.removeTypes(types[index]);
                    } else {
                      filterTab.addTypes(types[index]);
                    }
                  } else {
                    if(filterTab.bottomTypes[key]!.contains(types[index])) {
                      filterTab.removeBottomTypes(key, types[index]);
                    } else {
                      filterTab.addBottomTypes(key, types[index]);
                    }
                  }
                },
                child: outfitProvider.outfitIndex != 2 ?
                  Text(types[index], style: filterTab.types.contains(types[index]) ? Theme.of(context).textTheme.subtitle2 : Theme.of(context).textTheme.caption)
                  : Text(types[index], style: filterTab.bottomTypes[key]!.contains(types[index]) ? Theme.of(context).textTheme.subtitle2 : Theme.of(context).textTheme.caption)
              ),
            );
          }),
        ]
      )
    );
  }
}