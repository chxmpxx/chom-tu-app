import 'package:chom_tu/constants/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WardrobeInfoScreen extends StatelessWidget {
  const WardrobeInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/o3_back_1.svg', color: kColorsBlack),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset('assets/icons/o1_save_1.svg', color: kColorsBlack)
          ),
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset('assets/icons/a3_edit_1.svg', color: kColorsBlack)
          )
        ],
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: kColorsGrey
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Top', style: Theme.of(context).textTheme.headline1),
                    IconButton(
                      onPressed: (){},
                      icon: SvgPicture.asset('assets/icons/a1_heart_2.svg', color: kColorsRed)
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Text('Color', style: Theme.of(context).textTheme.headline2),
                    const SizedBox(width: 51),
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.purple[400],
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    Text('  Purple', style: Theme.of(context).textTheme.headline5),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Text('Type', style: Theme.of(context).textTheme.headline2),
                    const SizedBox(width: 54),
                    Text('Camisole', style: Theme.of(context).textTheme.headline5),
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