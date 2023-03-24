import 'package:chom_tu/common_widgets/line_widget.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/auth/models/user_model.dart';
import 'package:chom_tu/features/auth/providers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialSearch extends StatefulWidget {
  List<UserModel> users = [];
  final formKey = GlobalKey<FormState>();
  TextEditingController search = TextEditingController();
  SocialSearch({super.key});

  @override
  State<SocialSearch> createState() => _SocialSearchState();
}

class _SocialSearchState extends State<SocialSearch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: kColorsWhite,
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Row(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset('assets/icons/o3_back_1.svg', color: kColorsBlack),
                        onPressed: (){
                          Navigator.pushNamedAndRemoveUntil(context, '/social', (route) => true);
                        },
                      ),
                      Expanded(
                        child: textFormField(widget.formKey, widget.search),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 21),
                        child: InkWell(
                          onTap: () {
                            widget.search.text = '';
                            widget.users = [];
                            FocusManager.instance.primaryFocus?.unfocus();
                            setState(() {});
                          },
                          child: Text('Cancel', style: Theme.of(context).textTheme.headline2)
                        ),
                      )
                    ],
                  ),
                ),
                lineWidget(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 9),
                    child: ListView.builder(
                      itemCount: widget.users.length,
                      itemBuilder: (BuildContext context, int index) {
                        UserModel user = widget.users[index];
                
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  image: user.userImg != null ? DecorationImage(
                                    image: NetworkImage(user.userImg!),
                                    fit: BoxFit.cover,
                                  ) 
                                  : const DecorationImage(
                                    image: AssetImage('assets/user_chomtu_profile.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(user.username, style: Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                        );
                      }
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget textFormField(formKey, search) {
    return Form(
      key: formKey,
      child: SizedBox(
        height: 32,
        child: TextFormField(
          onChanged: (value) async {
            if (value.isNotEmpty) {
              widget.users = await UserController().getAllWardrobes(value);
            } else {
              widget.users = [];
            }
            setState(() {});
          },

          controller: search,
          keyboardType: TextInputType.text,
          autofocus: true,
          style: Theme.of(context).textTheme.headline5,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor: kColorsBlack,
          maxLines: 1,
        
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: Theme.of(context).textTheme.headline6,
            contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            filled: true,
            fillColor: kColorsLightGrey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

}