import 'dart:io';

import 'package:chom_tu/configs/themes/colors.dart';
import 'package:chom_tu/wardrobe/providers/wardrobe_provider.dart';
import 'package:chom_tu/wardrobe/widgets/wardrobe_circle_btn_widget.dart';
import 'package:chom_tu/wardrobe/widgets/wardrobe_drop_down_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WardrobeEditInfoScreen extends StatelessWidget {
  const WardrobeEditInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var wardrobeProvider = Provider.of<WardrobeProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: kColorsWhite,
      appBar: AppBar(
        shape: const Border(
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
          Consumer<WardrobeProvider>(
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
            child: Consumer<WardrobeProvider>(
              builder: (_, value, __) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    WardrobeDropDownField(list: const ['Top', 'B', 'C'], name: 'Category', value: wardrobeProvider.category),
                    wardrobeProvider.category == 'B' ? Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 93),
                            Expanded(
                              child: WardrobeCircleBtnWidget(list: const ['Skirts', 'Shorts', 'Trousers'], value: wardrobeProvider.subCategory)
                            )
                          ],
                        ),
                      ],
                    ) : Container(),
                    WardrobeDropDownField(list: const ['Red', 'B', 'C'], name: 'Color', value: wardrobeProvider.color),
                    WardrobeDropDownField(list: const ['Vest', 'B', 'C'], name: 'Type', value: wardrobeProvider.type),
                    const SizedBox(height: 10)
                  ],
                );
              }
            )
          )
        ],
      )
    );
  }
}