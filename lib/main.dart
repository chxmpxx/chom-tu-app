import 'package:chom_tu/configs/routes/routes.dart';
import 'package:chom_tu/configs/themes/style.dart';
import 'package:chom_tu/wardrobe/providers/filter_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
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
      ],
      child: MaterialApp(
        theme: appTheme(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.generateRoute,
      )
    );
  }
}