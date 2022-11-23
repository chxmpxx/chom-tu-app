import 'package:camera/camera.dart';
import 'package:chom_tu/configs/routes/routes.dart';
import 'package:chom_tu/configs/themes/style.dart';
import 'package:chom_tu/outfit/providers/delete_item_provider.dart';
import 'package:chom_tu/outfit/providers/is_delete_btn_active_provider.dart';
import 'package:chom_tu/outfit/providers/outfit_create_provider.dart';
import 'package:chom_tu/outfit/providers/show_delete_btn_provider.dart';
import 'package:chom_tu/wardrobe/providers/edit_tab_provider.dart';
import 'package:chom_tu/wardrobe/providers/filter_tab_provider.dart';
import 'package:chom_tu/wardrobe/screens/wardrobe_camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
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
        ChangeNotifierProvider(create: (context) => FilterTabProvider()),
        ChangeNotifierProvider(create: (context) => OutfitCreateProvider()),
        ChangeNotifierProvider(create: (context) => ShowDeleteBtnProvider()),
        ChangeNotifierProvider(create: (context) => IsDeleteBtnActiveProvider()),
        ChangeNotifierProvider(create: (context) => DeleteItemProvider()),
        ChangeNotifierProvider(create: (context) => EditTabProvider()),
      ],
      child: MaterialApp(
        theme: appTheme(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.generateRoute,
      )
    );
  }
}