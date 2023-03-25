import 'package:chom_tu/common_widgets/button_widget.dart';
import 'package:chom_tu/common_widgets/line_widget.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/auth/models/user_model.dart';
import 'package:chom_tu/features/auth/providers/user_controller.dart';
import 'package:chom_tu/features/profile/widgets/setting_bottom_sheet_widget.dart';
import 'package:chom_tu/features/social/models/post_model.dart';
import 'package:chom_tu/features/social/provider/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // todo: get current user id
    int userId = (ModalRoute.of(context)?.settings.arguments ?? -1) as int;
    bool isCurrentUser;

    if (userId == -1) {
      isCurrentUser = true;
    } else {
      isCurrentUser = true;
    }

    return FutureBuilder(
      future: UserController().getOneUser(userId),
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if(snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        else if(snapshot.connectionState == ConnectionState.done) {
          UserModel user = snapshot.data!;

          return Scaffold(
            backgroundColor: kColorsWhite,
            appBar: AppBar(
              centerTitle: isCurrentUser ? false : true,
              shape: const Border(
                bottom: BorderSide(
                  color: kColorsLightGrey,
                  width: kAppbarBorderWidth
                )
              ),
              elevation: 0,
              toolbarHeight: 60,
              title: Text(user.username, style: isCurrentUser ? Theme.of(context).textTheme.headline1 : Theme.of(context).textTheme.subtitle1),
              iconTheme: Theme.of(context).iconTheme,
              backgroundColor: kColorsWhite,
              automaticallyImplyLeading: isCurrentUser ? false : true,
              leading: isCurrentUser ? null : IconButton(
                icon: SvgPicture.asset('assets/icons/o3_back_1.svg', color: kColorsBlack),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              actions: isCurrentUser ? [
                IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/profile_edit');
                  },
                  icon: SvgPicture.asset('assets/icons/a3_edit_1.svg', color: kColorsBlack)
                ),
                IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/social_saved');
                  },
                  icon: SvgPicture.asset('assets/icons/a5_bookmark_1.svg', color: kColorsBlack)
                ),
                IconButton(
                  onPressed: (){
                    settingBottomSheetWidget(context);
                  },
                  icon: SvgPicture.asset('assets/icons/a5_setting_1.svg', color: kColorsBlack)
                )
              ] : null,
            ),
            body: ListView(
              children: [
                profileBody(context, user, isCurrentUser),
                const SizedBox(height: 22),
                lineWidget(),

                FutureBuilder(
                  future: PostController().getAllProfilePosts(userId),
                  builder: (BuildContext context, AsyncSnapshot<List<PostModel>> snapshot) {
                    if(snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                    else if(snapshot.connectionState == ConnectionState.done) {
                      List<PostModel> postList = snapshot.data!;
                      return allPostBody(postList);
                    }
                    else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
            ),
          );
        }
        else {
          return const Center(
            // child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget profileBody(context, UserModel user, bool isCurrentUser) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(22),
          child: Row(  
            children: [
              Container(
                width: (MediaQuery.of(context).size.width / 2) - 44,
                height: (MediaQuery.of(context).size.width / 2) - 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular((MediaQuery.of(context).size.width / 2) - 44)),
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
              const SizedBox(width: 22),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name, style: Theme.of(context).textTheme.headline2),
                  const SizedBox(height: 11),
                  Text(user.bio ?? '', style: Theme.of(context).textTheme.subtitle2),
                  isCurrentUser ? Container() : ButtonWidget(name: 'Follow', isSmall: true, onTap: () {})
                ],
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // todo: get Posts, Followers and Following
            Column(
              children: [
                Text('34', style: Theme.of(context).textTheme.headline2),
                const SizedBox(height: 11),
                const Text('Posts', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: kColorsDarkGrey)),
              ],
            ),
            Column(
              children: [
                Text('65.3K', style: Theme.of(context).textTheme.headline2),
                const SizedBox(height: 11),
                const Text('Followers', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: kColorsDarkGrey)),
              ],
            ),
            Column(
              children: [
                Text('65.3K', style: Theme.of(context).textTheme.headline2),
                const SizedBox(height: 11),
                const Text('Following', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: kColorsDarkGrey)),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget allPostBody(List<PostModel> postList) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: postList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1
      ),
      itemBuilder: (BuildContext context, int index) {
        PostModel post = postList[index];

        return Padding(
          padding: const EdgeInsets.only(left: 1, right: 1, bottom: 2),
          child: InkWell(
            onTap: (){
              // Navigator.pushNamed(context, '/social_post_info', arguments: post.id);
              Navigator.pushNamed(context, '/social_post_info', arguments: {"id": post.id, "route": '/profile'});
            },
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(post.postImg!),
                  fit: BoxFit.cover,
                ),
              ),
            )
          ),
        );
      }
    );
  }
}