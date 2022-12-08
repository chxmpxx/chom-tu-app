import 'package:chom_tu/auth/widgets/button_widget.dart';
import 'package:chom_tu/configs/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('ChomTu', style: Theme.of(context).textTheme.headline1),
          SizedBox(height: 45),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Username', style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 24),
                Row(
                  children: [
                    Text('Password', style: Theme.of(context).textTheme.headline6),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: SvgPicture.asset('assets/o7_eye_1.svg', color: kColorsDarkGrey)
                      ),
                    )
                  ],
                ),
                SizedBox(height: 11),
                Align(
                  alignment: Alignment.topRight,
                  child: Text('Forgot Your Password?', style: Theme.of(context).textTheme.caption)
                ),
                SizedBox(height: 24),
                ButtonWidget(name: 'Login', onTap: (){}),
                SizedBox(height: 11),
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Don\'t have an account?', style: Theme.of(context).textTheme.caption),
                      Text(' Sign up', style: Theme.of(context).textTheme.subtitle2),
                    ],
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}