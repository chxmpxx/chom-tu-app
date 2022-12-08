import 'package:chom_tu/auth/widgets/button_widget.dart';
import 'package:chom_tu/configs/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
        title: Text('Sign Up', style: Theme.of(context).textTheme.headline1),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        leading: IconButton(
          icon: SvgPicture.asset('assets/o3_back_1.svg', color: kColorsBlack),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 24),
            Text('Email', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 24),
            Text('Username', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 24),
            Text('Password', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 24),
            Text('Confirm Password', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 24),
            ButtonWidget(name: 'Sign up', onTap: (){}),
          ],
        ),
      ),
    );
  }
}