import 'package:chom_tu/configs/themes/colors.dart';
import 'package:chom_tu/wardrobe/providers/wardrobe_filter_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WardrobeCategoryWidget extends StatelessWidget {
  const WardrobeCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var wardrobeFilterTabProvider = Provider.of<WardrobeFilterTabProvider>(context, listen: false);
    List<String> list = ['Top', 'Bottom', 'Set', 'Shoes', 'Accessory'];
    List<String> iconList = ['a2_top_1.svg', 'a2_bottom_1.svg', 'a2_set_1.svg', 'a2_shoes_1.svg', 'a2_bag_1.svg'];

    return Consumer<WardrobeFilterTabProvider>(
      builder: (_, value, __) {
        return Column(
          children: [
            ...List.generate(list.length, (index) {
                return ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SvgPicture.asset('assets/${iconList[index]}', color: wardrobeFilterTabProvider.category == list[index] ? kColorsWhite : kColorsBlack),
                  ),
                  title: Text(list[index], style: wardrobeFilterTabProvider.category == list[index] ? Theme.of(context).textTheme.headline4 : Theme.of(context).textTheme.headline5),
                  tileColor: wardrobeFilterTabProvider.category == list[index] ? kColorsBlack : kColorsWhite,
                  onTap: (){
                    wardrobeFilterTabProvider.setCategory(list[index]);
                  },
                );
              }
            )
          ]
        );
      }
    );
  }
}