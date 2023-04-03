import 'package:chom_tu/common_widgets/text_form_field_widget.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/admin/providers/admin_provider.dart';
import 'package:chom_tu/features/admin/widgets/admin_drawer_widget.dart';
import 'package:chom_tu/features/auth/providers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AdminSettingScreen extends StatefulWidget {
  const AdminSettingScreen({Key? key}) : super(key: key);

  @override
  _AdminSettingScreenState createState() => _AdminSettingScreenState();
}

class _AdminSettingScreenState extends State<AdminSettingScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController charges;

  @override
  void initState() {
    super.initState();
    charges = TextEditingController();
  }

  @override
  void dispose() {
    charges.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var adminProvider = Provider.of<AdminProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: kColorsWhite,
        appBar: AppBar(
          shape: const Border(bottom: BorderSide(color: kColorsLightGrey, width: kAppbarBorderWidth)),
          elevation: 0,
          toolbarHeight: 60,
          centerTitle: true,
          title: Text('Setting', style: Theme.of(context).textTheme.subtitle1),
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: kColorsWhite,
          leading: Builder(
            builder: (context) => IconButton(
              icon: SvgPicture.asset('assets/icons/a1_hamburger_1.svg', color: kColorsBlack),
              onPressed: () {
                if (adminProvider.isEditCharges) {
                  adminProvider.setIsEditCharges();
                }
                Scaffold.of(context).openDrawer();
              }
            ),
          ),
          actions: [
            Consumer<AdminProvider>(
              builder: (_, value, __) {
              return adminProvider.isEditCharges
                ? Padding(
                  padding: const EdgeInsets.only(right: 22, top: 22),
                  child: InkWell(
                    onTap: () async {
                      if (adminProvider.isEditCharges && formKey.currentState!.validate()) {
                        formKey.currentState!.save();
    
                        adminProvider.setCharges(charges.text);
                        Map<String, String> data = {'charges': adminProvider.charges};
                        await UserController().automaticBanUser(data);
                      }
                      adminProvider.setIsEditCharges();
                    },
                    child: Text('Save', style: Theme.of(context).textTheme.headline5))
                )
                : IconButton(
                  onPressed: () {
                    adminProvider.setIsEditCharges();
                  },
                  icon: SvgPicture.asset('assets/icons/a3_edit_1.svg')
                );
              },
            )
          ],
        ),
        drawer: adminDrawer(context),
        body: Consumer<AdminProvider>(
          builder: (_, value, __) {
            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Maximum Charges', style: Theme.of(context).textTheme.headline2),
                        adminProvider.isEditCharges ? 
                        SizedBox(
                          width: 30,
                          child: Expanded(
                            child: TextFormFieldWidget(controller: charges, hintText: adminProvider.charges, validator: "Please enter charges")
                          ),
                        )
                        : Text(adminProvider.charges.toString(), style: Theme.of(context).textTheme.headline5),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('Total charge until user got banned', style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              )
            );
          }
        )
      ),
    );
  }
}