import 'dart:io';

import 'package:chom_tu/common_widgets/text_form_field_widget.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/auth/models/user_model.dart';
import 'package:chom_tu/features/auth/providers/user_controller.dart';
import 'package:chom_tu/features/dashboard/dashboard_provider.dart';
import 'package:chom_tu/features/profile/provider/profile_provider.dart';
import 'package:chom_tu/features/profile/widgets/profile_camera_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    var dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);

    final formKey = GlobalKey<FormState>();
    TextEditingController name = TextEditingController();
    TextEditingController username = TextEditingController();
    TextEditingController bio = TextEditingController();

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
          title: Text('Edit Profile', style: Theme.of(context).textTheme.subtitle1),
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: kColorsWhite,
          leading: IconButton(
            icon: SvgPicture.asset('assets/icons/o3_back_1.svg', color: kColorsBlack),
            onPressed: (){
              profileProvider.profileImg == "";
              Navigator.pop(context);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 22, top: 22),
              child: InkWell(
                onTap: () async {
                  Map<String, String> data = {
                    "name": name.text,
                    "username": username.text
                  };
                  await UserController().updateUser(data, context);

                  if(formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    profileProvider.profileImg == "";
                    dashboardProvider.setCurrentIndex(3);
                    Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => true);
                  }
                },
                child: Text('Save', style: Theme.of(context).textTheme.headline5)
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future: UserController().getCurrentUser(),
          builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
            if(snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            else if(snapshot.connectionState == ConnectionState.done) {
              UserModel user = snapshot.data!;

              name.text = user.name;
              username.text = user.username;
              bio.text = user.bio ?? '';

              return Consumer<ProfileProvider>(
                builder: (_, value, __) {
                  return Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 22),
                        InkWell(
                          onTap: () {
                            profileCameraBottomSheetWidget(context);
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 2) - 44,
                            height: (MediaQuery.of(context).size.width / 2) - 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular((MediaQuery.of(context).size.width / 2) - 44)),
                              image: profileProvider.profileImg == "" ?
                                user.userImg != null ? DecorationImage(
                                  image: NetworkImage(user.userImg!),
                                  fit: BoxFit.cover,
                                ) 
                                : const DecorationImage(
                                  image: AssetImage('assets/user_chomtu_profile.png'),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                image: FileImage(File(profileProvider.profileImg)),
                                fit: BoxFit.cover,
                              )
                            ),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  Text('Name', style: Theme.of(context).textTheme.headline2),
                                  const SizedBox(width: 48),
                                  Expanded(
                                    child: TextFormFieldWidget(controller: name, hintText: "Name", validator: "Please enter name")
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Username', style: Theme.of(context).textTheme.headline2),
                                  const SizedBox(width: 13),
                                  Expanded(
                                    child: TextFormFieldWidget(controller: username, hintText: "Username", validator: "Please enter username", name: 'username2')
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Bio', style: Theme.of(context).textTheme.headline2),
                                  const SizedBox(width: 68),
                                  Expanded(
                                    child: TextFormFieldWidget(controller: bio, hintText: "Bio", validator: " ")
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              );
            }
            else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      ),
    );
  }
}