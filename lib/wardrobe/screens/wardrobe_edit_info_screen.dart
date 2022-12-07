import 'dart:io';

import 'package:chom_tu/configs/themes/colors.dart';
import 'package:chom_tu/wardrobe/providers/wardrobe_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WardrobeEditInfoScreen extends StatelessWidget {
  const WardrobeEditInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var wardrobeProvider = Provider.of<WardrobeImageProvider>(context, listen: false);

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
        centerTitle: true,
        title: Text('Info', style: Theme.of(context).textTheme.headline1),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        leading: IconButton(
          icon: SvgPicture.asset('assets/o3_back_1.svg', color: kColorsBlack),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22, top: 22),
            child: InkWell(
              onTap: (){
                Navigator.pushNamed(context, '/wardrobe_camera_edit');
              },
              child: Text('Next', style: Theme.of(context).textTheme.headline5)
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Consumer<WardrobeImageProvider>(
            builder: (_, value, __) {
              return Container(
                color: kColorsGrey,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Image.file(
                  File(wardrobeProvider.currentPath!),
                  fit: wardrobeProvider.isGallery ? BoxFit.cover : BoxFit.fill,
                )
              );
            }
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                Row(
                  children: [
                    Text('Category', style: Theme.of(context).textTheme.headline2),
                    SizedBox(width: 20),
                    Text('Please select category', style: Theme.of(context).textTheme.headline6),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset('assets/o4_down_1.svg', color: kColorsBlack)
                      )
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Text('Color', style: Theme.of(context).textTheme.headline2),
                    SizedBox(width: 51),
                    Text('Please select color', style: Theme.of(context).textTheme.headline6),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset('assets/o4_down_1.svg', color: kColorsBlack)
                      )
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Text('Type', style: Theme.of(context).textTheme.headline2),
                    SizedBox(width: 54),
                    Text('Please enter type', style: Theme.of(context).textTheme.headline6),
                  ],
                )
              ],
            ),
          )
        ],
      )
    );
  }
}