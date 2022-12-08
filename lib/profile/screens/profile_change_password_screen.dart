import 'package:chom_tu/configs/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileChangePasswordScreen extends StatelessWidget {
  const ProfileChangePasswordScreen({Key? key}) : super(key: key);

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
        title: Text('Change Password', style: Theme.of(context).textTheme.subtitle1),
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
                Navigator.pop(context);
              },
              child: Text('Save', style: Theme.of(context).textTheme.headline5)
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Password', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 24),
            Text('New Password', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 24),
            Text('Confirm New Password', style: Theme.of(context).textTheme.headline6)
          ],
        ),
      ),
    );
  }
}