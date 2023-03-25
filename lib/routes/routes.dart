// import 'package:chom_tu/features/auth/screen/login_screen.dart';
import 'package:chom_tu/features/admin/screen/admin_history_screen.dart';
import 'package:chom_tu/features/admin/screen/admin_report_info_screen.dart';
import 'package:chom_tu/features/admin/screen/admin_report_screen.dart';
import 'package:chom_tu/features/admin/screen/admin_setting_screen.dart';
import 'package:chom_tu/features/admin/screen/admin_user_screen.dart';
import 'package:chom_tu/features/auth/screen/login_screen.dart';
import 'package:chom_tu/features/auth/screen/sign_up_screen.dart';
import 'package:chom_tu/features/dashboard/dashboard_screen.dart';
import 'package:chom_tu/features/outfit/screens/outfit_create_screen.dart';
import 'package:chom_tu/features/outfit/screens/outfit_edit_info_screen.dart';
import 'package:chom_tu/features/outfit/screens/outfit_favorite_screen.dart';
import 'package:chom_tu/features/outfit/screens/outfit_info_screen.dart';
import 'package:chom_tu/features/outfit/screens/outfit_screen.dart';
import 'package:chom_tu/features/profile/screens/profile_change_password_screen.dart';
import 'package:chom_tu/features/profile/screens/profile_edit_screen.dart';
import 'package:chom_tu/features/profile/screens/profile_screen.dart';
import 'package:chom_tu/features/social/screens/social_post_caption_screen.dart';
import 'package:chom_tu/features/social/screens/social_post_info_screen.dart';
import 'package:chom_tu/features/social/screens/social_post_screen.dart';
import 'package:chom_tu/features/social/screens/social_saved_screen.dart';
import 'package:chom_tu/features/social/screens/social_screen.dart';
import 'package:chom_tu/features/social/screens/social_search_screen.dart';
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

const routeDashboard = '/dashboard';

const routeWardrobe = '/wardrobe';
const routeWardrobeInfo = '/wardrobe_info';
const routeWardrobeCamera = '/wardrobe_camera';
const routeWardrobeCameraEdit = '/wardrobe_camera_edit';
const routeWardrobeEraser = '/wardrobe_eraser';
const routeWardrobeFavorite = '/wardrobe_favorite';
const routeWardrobeEditInfo = '/wardrobe_edit_info';

const routeOutfit = '/outfit';
const routeOutfitInfo = '/outfit_info';
const routeOutfitEditInfo = '/outfit_edit_info';
const routeOutfitCreate = '/outfit_create';
const routeOutfitFavorite = '/outfit_favorite';

const routeSocial = '/social';
const routeSocialSearch = '/social_search';
const routeSocialPostInfo = '/social_post_info';
const routeSocialPost = '/social_post';
const routeSocialPostCaption = '/social_post_caption';
const routeSocialSaved = '/social_saved';

const routeProfile = '/profile';
const routeProfileEdit = '/profile_edit';
const routeProfileChangePassword = '/profile_change_password';

const routeAdminUser = '/admin_user';
const routeAdminReport = '/admin_report';
const routeAdminReportInfo = '/admin_report_info';
const routeAdminHistory = '/admin_history';
const routeAdminSetting = '/admin_setting';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeDashboard:
        return PageTransition(
          child: const DashboardScreen(), 
          type: PageTransitionType.rightToLeft
        );

      case routeWardrobe:
        return PageTransition(
          child: const WardrobeScreen(), 
          type: PageTransitionType.rightToLeft
        );
      case routeWardrobeInfo:
        return PageTransition(
          child: const WardrobeInfoScreen(), 
          type: PageTransitionType.rightToLeft,
          settings: settings
        );
      case routeWardrobeCamera:
        return MaterialPageRoute(
          builder: (_) => const WardrobeCameraScreen()
        );
      case routeWardrobeCameraEdit:
        return MaterialPageRoute(
          builder: (_) => const WardrobeCameraEditScreen(),
          settings: settings
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
          type: PageTransitionType.rightToLeft,
          settings: settings
        );
        
      case routeOutfit:
        return PageTransition(
          child: const OutfitScreen(), 
          type: PageTransitionType.rightToLeft
        );
      case routeOutfitInfo:
        return PageTransition(
          child: const OutfitInfoScreen(), 
          type: PageTransitionType.rightToLeft,
          settings: settings
        );
      case routeOutfitEditInfo:
        return PageTransition(
          child: const OutfitEditInfoScreen(), 
          type: PageTransitionType.rightToLeft,
          settings: settings
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
      case routeSocialSearch:
        return PageTransition(
          child: SocialSearch(), 
          type: PageTransitionType.rightToLeft
        );
      case routeSocialPostInfo:
        return PageTransition(
          child: const SocialPostInfoScreen(), 
          type: PageTransitionType.rightToLeft,
          settings: settings
        );
      case routeSocialPost:
        return PageTransition(
          child: const SocialPostScreen(), 
          type: PageTransitionType.rightToLeft
        );
      case routeSocialPostCaption:
        return PageTransition(
          child: const SocialPostCaptionScreen(), 
          type: PageTransitionType.rightToLeft,
          settings: settings
        );
      case routeSocialSaved:
        return PageTransition(
          child: const SocialSavedScreen(), 
          type: PageTransitionType.rightToLeft
        );

      case routeProfile:
        return PageTransition(
          child: const ProfileScreen(), 
          type: PageTransitionType.rightToLeft,
          settings: settings
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

      case routeAdminUser:
        return MaterialPageRoute(
          builder: (_) => const AdminUserScreen()
        );
      case routeAdminReport:
        return MaterialPageRoute(
          builder: (_) => const AdminReportScreen()
        );
      case routeAdminReportInfo:
        return MaterialPageRoute(
          builder: (_) => const AdminReportInfoScreen(),
          settings: settings
        );
      case routeAdminHistory:
        return MaterialPageRoute(
          builder: (_) => const AdminHistoryScreen()
        );
      case routeAdminSetting:
        return MaterialPageRoute(
          builder: (_) => const AdminSettingScreen()
        );

      // Login
      default:
        return PageTransition(
          child: const LoginScreen(),
          type: PageTransitionType.rightToLeft
        );
    }
  }
}