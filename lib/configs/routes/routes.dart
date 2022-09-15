import 'package:chom_tu/dashboard_screen.dart';
import 'package:chom_tu/outfit/screens/outfit_screen.dart';
import 'package:chom_tu/profile/screens/profile_screen.dart';
import 'package:chom_tu/social/screens/social_screen.dart';
import 'package:chom_tu/wardrobe/screens/wardrobe_screen.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

const routeWardrobe = '/wardrobe';
const routeOutfit = '/outfit';
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
      case routeOutfit:
        return PageTransition(
          child: OutfitScreen(), 
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