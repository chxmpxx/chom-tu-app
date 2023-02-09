// import 'package:chom_tu/features/auth/screen/login_screen.dart';
import 'package:chom_tu/features/auth/screen/sign_up_screen.dart';
import 'package:chom_tu/dashboard_screen.dart';
import 'package:chom_tu/features/outfit/screens/outfit_create_screen.dart';
import 'package:chom_tu/features/outfit/screens/outfit_favorite_screen.dart';
import 'package:chom_tu/features/outfit/screens/outfit_info_screen.dart';
import 'package:chom_tu/features/outfit/screens/outfit_screen.dart';
import 'package:chom_tu/features/profile/screens/profile_change_password_screen.dart';
import 'package:chom_tu/features/profile/screens/profile_edit_screen.dart';
import 'package:chom_tu/features/profile/screens/profile_screen.dart';
import 'package:chom_tu/features/social/screens/social_post_caption_screen.dart';
import 'package:chom_tu/features/social/screens/social_post_screen.dart';
import 'package:chom_tu/features/social/screens/social_saved_screen.dart';
import 'package:chom_tu/features/social/screens/social_screen.dart';
import 'package:chom_tu/features/wardrobe/screens/wardrobe_camera_edit_screen.dart';
// import 'package:chom_tu/features/wardrobe/screens/wardrobe_camera_edit_screen.dart';
import 'package:chom_tu/features/wardrobe/screens/wardrobe_camera_screen.dart';
import 'package:chom_tu/features/wardrobe/screens/wardrobe_edit_info_screen.dart';
import 'package:chom_tu/features/wardrobe/screens/wardrobe_eraser_screen.dart';
import 'package:chom_tu/features/wardrobe/screens/wardrobe_favorite_screen.dart';
import 'package:chom_tu/features/wardrobe/screens/wardrobe_info_screen.dart';
import 'package:chom_tu/features/wardrobe/screens/wardrobe_screen.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

const routeLogin = '/login';
const routeSignUp = '/sign_up';

const routeWardrobe = '/wardrobe';
const routeWardrobeInfo = '/wardrobe_info';
const routeWardrobeCamera = '/wardrobe_camera';
const routeWardrobeCameraEdit = '/wardrobe_camera_edit';
const routeWardrobeEraser = '/wardrobe_eraser';
const routeWardrobeFavorite = '/wardrobe_favorite';
const routeWardrobeEditInfo = '/wardrobe_edit_info';

const routeOutfit = '/outfit';
const routeOutfitInfo = '/outfit_info';
const routeOutfitCreate = '/outfit_create';
const routeOutfitFavorite = '/outfit_favorite';

const routeSocial = '/social';
const routeSocialPost = '/social_post';
const routeSocialPostCaptionScreen = '/social_post_caption';
const routeSocialSavedScreen = '/social_saved';

const routeProfile = '/profile';
const routeProfileEdit = '/profile_edit';
const routeProfileChangePassword = '/profile_change_password';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeWardrobe:
        return PageTransition(
          child: const WardrobeScreen(), 
          type: PageTransitionType.rightToLeft
        );
      case routeWardrobeInfo:
        return PageTransition(
          child: const WardrobeInfoScreen(), 
          type: PageTransitionType.rightToLeft
        );
      case routeWardrobeCamera:
        return MaterialPageRoute(
          builder: (_) => const WardrobeCameraScreen()
        );
      case routeWardrobeCameraEdit:
        return MaterialPageRoute(
          builder: (_) => const WardrobeCameraEditScreen()
        );
      case routeWardrobeEraser:
        return MaterialPageRoute(
          builder: (_) => const WardrobeEraserScreen()
        );
      case routeWardrobeFavorite:
        return PageTransition(
          child: const WardrobeFavoriteScreen(), 
          type: PageTransitionType.rightToLeft
        );
      case routeWardrobeEditInfo:
        return PageTransition(
          child: const WardrobeEditInfoScreen(), 
          type: PageTransitionType.rightToLeft
        );
        
      case routeOutfit:
        return PageTransition(
          child: const OutfitScreen(), 
          type: PageTransitionType.rightToLeft
        );
      case routeOutfitInfo:
        return PageTransition(
          child: const OutfitInfoScreen(), 
          type: PageTransitionType.rightToLeft
        );
      case routeOutfitCreate:
        return PageTransition(
          child: const OutfitCreateScreen(), 
          type: PageTransitionType.rightToLeft
        );
      case routeOutfitFavorite:
        return PageTransition(
          child: const OutfitFavoriteScreen(), 
          type: PageTransitionType.rightToLeft
        );

      case routeSocial:
        return PageTransition(
          child: const SocialScreen(), 
          type: PageTransitionType.rightToLeft
        );
      case routeSocialPost:
        return PageTransition(
          child: const SocialPostScreen(), 
          type: PageTransitionType.rightToLeft
        );
      case routeSocialPostCaptionScreen:
        return PageTransition(
          child: const SocialPostCaptionScreen(), 
          type: PageTransitionType.rightToLeft
        );
      case routeSocialSavedScreen:
        return PageTransition(
          child: const SocialSavedScreen(), 
          type: PageTransitionType.rightToLeft
        );

      case routeProfile:
        return PageTransition(
          child: const ProfileScreen(), 
          type: PageTransitionType.rightToLeft
        );
      case routeProfileEdit:
        return PageTransition(
          child: const ProfileEditScreen(), 
          type: PageTransitionType.rightToLeft
        );
      case routeProfileChangePassword:
        return PageTransition(
          child: const ProfileChangePasswordScreen(),
          type: PageTransitionType.rightToLeft
        );

      case routeSignUp:
        return PageTransition(
          child: const SignUpScreen(),
          type: PageTransitionType.rightToLeft
        );

      // Login
      default:
        return PageTransition(
          child: const DashboardScreen(), 
          type: PageTransitionType.rightToLeft
        );
    }
  }
}