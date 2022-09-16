import 'package:chom_tu/configs/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OutfitNavigationBarWidget extends StatelessWidget {
  const OutfitNavigationBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: kColorsWhite,
        labelTextStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)
        )
      ),

      child: NavigationBar(
        height: 75,
        backgroundColor: kColorsWhite,
        onDestinationSelected: (index) {},
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset('assets/a2_top_1.svg', color: kColorsBlack),
            label: 'Tops',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('assets/a2_bottom_1.svg', color: kColorsBlack),
            label: 'Bottoms',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('assets/a2_set_1.svg', color: kColorsBlack),
            label: 'Set',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('assets/a2_shoes_1.svg', color: kColorsBlack),
            label: 'Shoes',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('assets/a2_bag_1.svg', color: kColorsBlack),
            label: 'Accessory',
          ),
        ],
      ),
    );
  }
}