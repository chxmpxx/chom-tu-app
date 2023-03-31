import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/auth/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String validator;
  final bool isPassword;
  final bool isAutofocus;
  final bool isCaption;
  final bool isDetail;
  final String name;
  const TextFormFieldWidget({Key? key, required this.controller, required this.hintText, required this.validator, this.isPassword = false, this.isAutofocus = false, this.isCaption = false, this.isDetail = false, this.name = 'None'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    bool passwordVisible = false;

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      autofocus: isAutofocus,
      style: Theme.of(context).textTheme.headline5,
      autocorrect: false,
      enableSuggestions: false,
      obscureText: isPassword ? !passwordVisible : false,
      cursorColor: kColorsBlack,

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.headline6,
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        enabledBorder: const UnderlineInputBorder(      
          borderSide: BorderSide(color: kColorsLightGrey),   
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kColorsLightGrey),
        ),
        errorStyle: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: kColorsRed),

        // suffixIcon: isPassword ? IconButton(
        //   icon: passwordVisible ? SvgPicture.asset('assets/icons/o7_eye_1.svg', color: kColorsDarkGrey) : SvgPicture.asset('assets/icons/o7_eye_2.svg', color: kColorsDarkGrey),
        //   onPressed: (){
        //     passwordVisible = !passwordVisible;
        //   },
        // ) : null,
      ),

      validator: (value) {
        if (value!.isEmpty) {
          if (isDetail || isCaption) {
            controller.text = 'None';
            return null;
          }
          return validator;
        } else if (name == 'email' && userProvider.existingEmail) {
          return 'Another account is using the same email.';
        } else if ((name == 'username' || name == 'username2') && userProvider.existingUsername) {
          return name == 'username2' ? 'This username isn\'t available.' : 'This username isn\'t available. Please try another.';
        } else if (name == 'password' && userProvider.passwordNotMatch) {
          return 'Password not match.';
        } else if (name == 'usernameLogin' && userProvider.noAccount) {
          return 'No account with this username has been registered.';
        } else if (name == 'passwordLogin' && userProvider.passwordIncorrect) {
          return 'The password that you\'ve entered is incorrect.';
        } else if (name == 'passwordLogin' && userProvider.banned) {
          return 'You have been banned!';
        } else {
          return null;
        }
      },
    );
  }
}
