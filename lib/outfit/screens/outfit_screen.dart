import 'package:chom_tu/configs/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OutfitScreen extends StatelessWidget {
  const OutfitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        title: Text('Outfit', style: Theme.of(context).textTheme.headline1),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        actions: [
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset('assets/a1_add_1.svg', color: kColorsBlack)
          ),
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset('assets/a1_heart_1.svg', color: kColorsBlack)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(1),
        child: Material(
          child: GridView.builder(
            itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1
              ),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(1),
                  child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: kColorsGrey2
                        ),
                      ),
                      Positioned(
                        top: -10,
                        right: -10,
                        child: IconButton(
                          onPressed: (){},
                          icon: SvgPicture.asset('assets/o2_heart_1.svg')
                        ),
                      ),
                    ],
                  ),
                );
              }
          ),
        ),
      )
    );
  }
}