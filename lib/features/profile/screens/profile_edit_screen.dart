import 'package:chom_tu/constants/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

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
        title: Text('Edit Profile', style: Theme.of(context).textTheme.subtitle1),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/o3_back_1.svg', color: kColorsBlack),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22, top: 22),
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Text('Save', style: Theme.of(context).textTheme.headline5)
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 22),
          Container(
            width: (MediaQuery.of(context).size.width / 2) - 44,
            height: (MediaQuery.of(context).size.width / 2) - 44,
            decoration: BoxDecoration(
              color: kColorsGrey,
              borderRadius: BorderRadius.all(Radius.circular((MediaQuery.of(context).size.width / 2) - 44)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Row(
                  children: [
                    Text('Name', style: Theme.of(context).textTheme.headline2),
                    const SizedBox(width: 48),
                    Text('Chompoo', style: Theme.of(context).textTheme.headline5),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Text('Username', style: Theme.of(context).textTheme.headline2),
                    const SizedBox(width: 13),
                    Text('Arreeya', style: Theme.of(context).textTheme.headline5),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Text('Bio', style: Theme.of(context).textTheme.headline2),
                    const SizedBox(width: 68),
                    Text('Hope you like my outfits :D', style: Theme.of(context).textTheme.headline5),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}