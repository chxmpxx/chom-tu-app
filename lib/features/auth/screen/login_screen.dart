import 'package:chom_tu/features/auth/widgets/button_widget.dart';
import 'package:chom_tu/common_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
                      TextFormFieldWidget(controller: username, hintText: "Username", validator: "Please enter username"),
                      TextFormFieldWidget(controller: password, hintText: "Password", validator: "Please enter password", isPassword: true),
                      const SizedBox(height: 11),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text('Forgot your password?', style: Theme.of(context).textTheme.caption)
                      ),
                      ButtonWidget(name: 'Login', onTap: (){}),
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