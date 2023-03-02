import 'package:chom_tu/constants/themes/colors.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String validator;
  final bool isPassword;
  final bool isAutofocus;
  final bool isCaption;
  final bool isDetail;
  const TextFormFieldWidget({Key? key, required this.controller, required this.hintText, required this.validator, this.isPassword = false, this.isAutofocus = false, this.isCaption = false, this.isDetail = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool passwordVisible = false;

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      autofocus: isAutofocus,
      style: Theme.of(context).textTheme.headline5,
      autocorrect: false,
      enableSuggestions: false,
      obscureText: isPassword ? !passwordVisible : false,

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
        } return null;
      },
    );
  }
}
