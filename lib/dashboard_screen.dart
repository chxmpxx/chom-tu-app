import 'package:chom_tu/configs/themes/color.dart';
import 'package:chom_tu/outfit/screens/outfit_screen.dart';
import 'package:chom_tu/profile/screens/profile_screen.dart';
import 'package:chom_tu/social/screens/social_screen.dart';
import 'package:chom_tu/wardrobe/screens/wardrobe_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int _currentIndex = 0;

  final screens = [
    WardrobeScreen(),
    OutfitScreen(),
    SocialScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: kColorsWhite,
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 14, fontWeight: FontWeight.w500)
          )
        ),

        child: NavigationBar(
          height: 60,
          backgroundColor: kColorsWhite,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
              icon: SvgPicture.asset('assets/b1_wardrobe_1.svg', color: kColorsBlack),
              selectedIcon: SvgPicture.asset('assets/b1_wardrobe_2.svg'),
              label: 'Wardrobe',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('assets/b1_hanger_1.svg', color: kColorsBlack),
              selectedIcon: SvgPicture.asset('assets/b1_hanger_2.svg', color: kColorsBlack),
              label: 'Outfit',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('assets/b1_social_1.svg'),
              selectedIcon: SvgPicture.asset('assets/b1_social_2.svg'),
              label: 'Social',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('assets/b1_profile_1.svg', color: kColorsBlack),
              selectedIcon: SvgPicture.asset('assets/b1_profile_2.svg', color: kColorsBlack),
              label: 'Profile',
            ),
          ],
        ),
      )
    );
  }
}