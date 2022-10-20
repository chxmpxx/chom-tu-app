import 'package:chom_tu/dashboard_screen.dart';
import 'package:chom_tu/outfit/screens/outfit_create_screen.dart';
import 'package:chom_tu/outfit/screens/outfit_info_screen.dart';
import 'package:chom_tu/outfit/screens/outfit_screen.dart';
import 'package:chom_tu/profile/screens/profile_screen.dart';
import 'package:chom_tu/social/screens/social_screen.dart';
// import 'package:chom_tu/wardrobe/screens/wardrobe_camera_edit_screen.dart';
import 'package:chom_tu/wardrobe/screens/wardrobe_camera_screen.dart';
import 'package:chom_tu/wardrobe/screens/wardrobe_info_screen.dart';
import 'package:chom_tu/wardrobe/screens/wardrobe_screen.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

const routeWardrobe = '/wardrobe';
const routeWardrobeInfo = '/wardrobe_info';
const routeWardrobeCamera = '/wardrobe_camera';
// const routeWardrobeCameraEdit = '/wardrobe_camera_edit';
const routeOutfit = '/outfit';
const routeOutfitInfo = '/outfit_info';
const routeOutfitCreate = '/outfit_create';
const routeSocial = '/social';
const routeProfile = '/profile';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeWardrobe:
        return PageTransition(
          child: WardrobeScreen(), 
          type: PageTransitionType.rightToLeft
        );
      case routeWardrobeInfo:
        return PageTransition(
          child: WardrobeInfoScreen(), 
          type: PageTransitionType.rightToLeft
        );
      case routeWardrobeCamera:
        return MaterialPageRoute(
          builder: (_) => WardrobeCameraScreen()
        );
      // case routeWardrobeCameraEdit:
        // return MaterialPageRoute(
        //   builder: (_) => WardrobeCameraEditScreen()
        // );
        
      case routeOutfit:
        return PageTransition(
          child: OutfitScreen(), 
          type: PageTransitionType.rightToLeft
        );
      case routeOutfitInfo:
        return PageTransition(
          child: OutfitInfoScreen(), 
          type: PageTransitionType.rightToLeft
        );
      case routeOutfitCreate:
        return PageTransition(
          child: OutfitCreateScreen(), 
          type: PageTransitionType.rightToLeft
        );

      case routeSocial:
        return PageTransition(
          child: SocialScreen(), 
          type: PageTransitionType.rightToLeft
        );
      case routeProfile:
        return PageTransition(
          child: ProfileScreen(), 
          type: PageTransitionType.rightToLeft
        );

      // Login
      default:
        return PageTransition(
          child: DashboardScreen(), 
          type: PageTransitionType.rightToLeft
        );
    }
  }
}