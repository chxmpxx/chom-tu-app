import 'package:chom_tu/configs/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialPostScreen extends StatelessWidget {
  const SocialPostScreen({Key? key}) : super(key: key);

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
              onTap: (){
                Navigator.pushNamed(context, '/social_post_caption');
              },
              child: Text('Next', style: Theme.of(context).textTheme.headline5)
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
          Container(
            height: 60,
            color: kColorsWhite,
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('Please select outfit', style: Theme.of(context).textTheme.headline2)
              ),
            )
          ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1
              ),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 1, right: 1, bottom: 2),
                  child: InkWell(
                    onTap: (){},
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: kColorsGrey
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}