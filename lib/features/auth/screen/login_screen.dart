import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/admin/providers/admin_provider.dart';
import 'package:chom_tu/features/auth/providers/user_controller.dart';
import 'package:chom_tu/features/auth/providers/user_provider.dart';
import 'package:chom_tu/common_widgets/button_widget.dart';
import 'package:chom_tu/common_widgets/text_form_field_widget.dart';
import 'package:chom_tu/features/dashboard/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    var adminProvider = Provider.of<AdminProvider>(context, listen: false);

    final formKey = GlobalKey<FormState>();
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: kColorsWhite,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text('ChomTu', style: Theme.of(context).textTheme.headline1)
              ),
              const SizedBox(height: 13),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormFieldWidget(controller: username, hintText: "Username", validator: "Please enter username", name: 'usernameLogin'),
                      TextFormFieldWidget(controller: password, hintText: "Password", validator: "Please enter password", isPassword: true, name: 'passwordLogin'),
                      const SizedBox(height: 11),
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: Text('Forgot your password?', style: Theme.of(context).textTheme.caption)
                      // ),
                      ButtonWidget(
                        name: 'Login',
                        onTap: () async {
                          var data = {"username": username.value.text, "password": password.value.text};
                          String role = await UserController().login(data, context);

                          if(formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            dashboardProvider.setCurrentIndex(0);
                            adminProvider.setMenu('User');

                            role == 'Admin' ? Navigator.pushNamedAndRemoveUntil(context, '/admin_user', (route) => true)
                            : Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => true);
                          }
                        },
                      ),
                      const SizedBox(height: 11),
                      Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Don\'t have an account?', style: Theme.of(context).textTheme.caption),
                            InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, '/sign_up');
                              },
                              child: Text(' Sign up', style: Theme.of(context).textTheme.subtitle2)
                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}