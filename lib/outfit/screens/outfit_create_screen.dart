import 'package:chom_tu/configs/themes/constants.dart';
import 'package:chom_tu/outfit/widgets/outfit_navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OutfitCreateScreen extends StatelessWidget {
  const OutfitCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorsWhite,
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: kColorsGrey2,
            width: kAppbarBorderWidth
          )
        ),
        elevation: 0,
        toolbarHeight: 60,
        centerTitle: true,
        title: Text('Create', style: Theme.of(context).textTheme.headline1),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        leading: IconButton(
          icon: SvgPicture.asset('assets/o3_back_1.svg', color: kColorsBlack),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset('assets/o1_save_1.svg', color: kColorsBlack)
          ),
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset('assets/o1_true_1.svg', color: kColorsBlack)
          )
        ],
      ),
      bottomNavigationBar: OutfitNavigationBarWidget(),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: kColorsGrey3
            ),
          ),
        ),
      )
    );
  }
}