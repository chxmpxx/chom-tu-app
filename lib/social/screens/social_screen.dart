import 'package:chom_tu/configs/themes/colors.dart';
import 'package:chom_tu/social/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorsWhite,
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: kColorsLightGrey,
            width: kAppbarBorderWidth
          )
        ),
        elevation: 0,
        toolbarHeight: 60,
        title: Text('ChomTu', style: Theme.of(context).textTheme.headline1),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        actions: [
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset('assets/a1_add_1.svg', color: kColorsBlack)
          ),
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset('assets/a5_bookmark_1.svg', color: kColorsBlack)
          )
        ],
      ),
      body: ListView(
        children: [
          PostWidget(),
          PostWidget()
        ],
      ),
    );
  }
}