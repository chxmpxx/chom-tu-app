import 'package:chom_tu/features/auth/models/user_model.dart';
import 'package:chom_tu/features/auth/providers/user_controller.dart';
import 'package:chom_tu/features/auth/providers/user_provider.dart';
import 'package:chom_tu/common_widgets/button_widget.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/common_widgets/text_form_field_widget.dart';
import 'package:chom_tu/features/dashboard/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    dashboardProvider.setCurrentIndex(0);

    final formKey = GlobalKey<FormState>();
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
          title: Text('Sign Up', style: Theme.of(context).textTheme.headline1),
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: kColorsWhite,
          leading: IconButton(
            icon: SvgPicture.asset('assets/icons/o3_back_1.svg', color: kColorsBlack),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(22),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                TextFormFieldWidget(controller: name, hintText: "Name", validator: "Please enter name"),
                TextFormFieldWidget(controller: email, hintText: "Email", validator: "Please enter email", name: 'email'),
                TextFormFieldWidget(controller: username, hintText: "Username", validator: "Please enter username", name: 'username'),
                TextFormFieldWidget(controller: password, hintText: "Password", validator: "Please enter password", isPassword: true),
                TextFormFieldWidget(controller: confirmPassword, hintText: "Confirm Password", validator: "Please enter confirm password", isPassword: true, name: 'password'),
                ButtonWidget(
                  name: 'Sign up',
                  onTap: () async {
                    UserModel data = UserModel(name: name.value.text, email: email.value.text, username: username.value.text, password: password.value.text, confirmPassword: confirmPassword.value.text);
                    await UserController().signUp(data, context);

                    if(formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => true);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}