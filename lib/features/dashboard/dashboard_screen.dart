import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/dashboard/dashboard_provider.dart';
import 'package:chom_tu/features/outfit/screens/outfit_screen.dart';
import 'package:chom_tu/features/profile/provider/profile_provider.dart';
import 'package:chom_tu/features/profile/screens/profile_screen.dart';
import 'package:chom_tu/features/social/screens/social_screen.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_filter_tab_provider.dart';
import 'package:chom_tu/features/wardrobe/screens/wardrobe_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    const WardrobeScreen(),
    const OutfitScreen(),
    const SocialScreen(),
    const ProfileScreen(),
    const ProfileScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    var wardrobeFilterTab = Provider.of<WardrobeFilterTabProvider>(context, listen: true);
    var dashboardProvider = Provider.of<DashboardProvider>(context, listen: true);
    currentIndex = dashboardProvider.currentIndex;

    if (currentIndex == 3) {
      profileProvider.setProfile(true, -1);
    }

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: kColorsWhite,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)
          )
        ),

        child: NavigationBar(
          height: 60,
          backgroundColor: kColorsWhite,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: currentIndex == 4 ? 2 : currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              wardrobeFilterTab.removeAll();
              dashboardProvider.setCurrentIndex(index);
            });
          },
          destinations: [
            NavigationDestination(
              icon: SvgPicture.asset('assets/icons/b1_wardrobe_1.svg', color: kColorsBlack),
              selectedIcon: SvgPicture.asset('assets/icons/b1_wardrobe_2.svg'),
              label: 'Wardrobe',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('assets/icons/b1_hanger_1.svg', color: kColorsBlack),
              selectedIcon: SvgPicture.asset('assets/icons/b1_hanger_2.svg', color: kColorsBlack),
              label: 'Outfit',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('assets/icons/b1_social_1.svg'),
              selectedIcon: SvgPicture.asset('assets/icons/b1_social_2.svg'),
              label: 'Social',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('assets/icons/b1_profile_1.svg', color: kColorsBlack),
              selectedIcon: SvgPicture.asset('assets/icons/b1_profile_2.svg', color: kColorsBlack),
              label: 'Profile',
            ),
          ],
        ),
      )
    );
  }
}