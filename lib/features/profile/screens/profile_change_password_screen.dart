import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/common_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileChangePasswordScreen extends StatelessWidget {
  const ProfileChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController currentPassword = TextEditingController();
    TextEditingController newPassword = TextEditingController();
    TextEditingController confirmNewPassword = TextEditingController();

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
          title: Text('Change Password', style: Theme.of(context).textTheme.subtitle1),
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
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormFieldWidget(controller: currentPassword, hintText: "Current Password", validator: "Please enter current password", isPassword: true),
                TextFormFieldWidget(controller: newPassword, hintText: "New Password", validator: "Please enter new password", isPassword: true),
                TextFormFieldWidget(controller: confirmNewPassword, hintText: "Confirm New Password", validator: "Please enter confirm new password", isPassword: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}