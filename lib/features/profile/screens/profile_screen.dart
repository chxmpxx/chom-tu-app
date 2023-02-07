import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/profile/widgets/setting_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
        title: Text('Arreeya', style: Theme.of(context).textTheme.headline1),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        actions: [
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset('assets/icons/a1_add_1.svg', color: kColorsBlack)
          ),
          IconButton(
            onPressed: (){
              settingBottomSheetWidget(context);
            },
            icon: SvgPicture.asset('assets/icons/a5_setting_1.svg', color: kColorsBlack)
          )
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(22),
                child: Row(  
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width / 2) - 44,
                      height: (MediaQuery.of(context).size.width / 2) - 44,
                      decoration: BoxDecoration(
                        color: kColorsGrey,
                        borderRadius: BorderRadius.all(Radius.circular((MediaQuery.of(context).size.width / 2) - 44)),
                      ),
                    ),
                    const SizedBox(width: 22),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Chompoo', style: Theme.of(context).textTheme.headline2),
                        const SizedBox(height: 11),
                        Text('Hope you like my outfits :D', style: Theme.of(context).textTheme.subtitle2),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text('34', style: Theme.of(context).textTheme.headline2),
                      const SizedBox(height: 11),
                      const Text('Posts', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: kColorsDarkGrey)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('65.3K', style: Theme.of(context).textTheme.headline2),
                      const SizedBox(height: 11),
                      const Text('Likes', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: kColorsDarkGrey)),
                    ],
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 22),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 20,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1
            ),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 1, right: 1, bottom: 2),
                child: InkWell(
                  onTap: (){},
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      color: kColorsGrey
                    ),
                  ),
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}