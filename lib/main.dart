import 'package:camera/camera.dart';
import 'package:chom_tu/routes/routes.dart';
import 'package:chom_tu/constants/themes/style.dart';
import 'package:chom_tu/features/outfit/providers/delete_item_provider.dart';
import 'package:chom_tu/features/outfit/providers/is_delete_btn_active_provider.dart';
import 'package:chom_tu/features/outfit/providers/outfit_create_provider.dart';
import 'package:chom_tu/features/outfit/providers/outfit_filter_tab_provider.dart';
import 'package:chom_tu/features/outfit/providers/show_delete_btn_provider.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_provider.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_filter_tab_provider.dart';
import 'package:chom_tu/features/wardrobe/screens/wardrobe_camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  ));
  runApp(
    const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WardrobeFilterTabProvider()),
        ChangeNotifierProvider(create: (context) => OutfitCreateProvider()),
        ChangeNotifierProvider(create: (context) => ShowDeleteBtnProvider()),
        ChangeNotifierProvider(create: (context) => IsDeleteBtnActiveProvider()),
        ChangeNotifierProvider(create: (context) => DeleteItemProvider()),
        ChangeNotifierProvider(create: (context) => WardrobeProvider()),
        ChangeNotifierProvider(create: (context) => OutfitFilterTabProvider()),
      ],
      child: MaterialApp(
        theme: appTheme(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.generateRoute,
      )
    );
  }
}