import 'package:chom_tu/configs/themes/colors.dart';
import 'package:flutter/material.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kColorsWhite,
      body: Center(
        child: Text('Coming soon...', style: TextStyle(color: kColorsBlack),),
      ),
    );
  }
}