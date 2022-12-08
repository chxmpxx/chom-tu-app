import 'package:chom_tu/configs/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialPostCaptionScreen extends StatelessWidget {
  const SocialPostCaptionScreen({Key? key}) : super(key: key);

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
        centerTitle: true,
        title: Text('Post', style: Theme.of(context).textTheme.headline1),
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
              onTap: (){},
              child: Text('Share', style: Theme.of(context).textTheme.headline5)
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: kColorsGrey,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
          ),
          Expanded(
            child: Container(
              height: 60,
              color: kColorsWhite,
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Text('Caption', style: Theme.of(context).textTheme.headline2),
                      SizedBox(width: 32),
                      Text('Write a caption...', style: Theme.of(context).textTheme.headline6),
                    ],
                  )
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}