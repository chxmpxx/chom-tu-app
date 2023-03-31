import 'package:chom_tu/common_widgets/button_widget.dart';
import 'package:chom_tu/common_widgets/line_widget.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/auth/models/user_model.dart';
import 'package:chom_tu/features/dashboard/dashboard_provider.dart';
import 'package:chom_tu/features/profile/provider/follower_controller.dart';
import 'package:chom_tu/features/profile/provider/profile_provider.dart';
import 'package:chom_tu/features/profile/widgets/setting_bottom_sheet_widget.dart';
import 'package:chom_tu/features/social/models/post_model.dart';
import 'package:chom_tu/features/social/provider/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    var dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);

    return FutureBuilder(
      future: PostController().getAllProfilePosts(profileProvider.isCurrentUser, profileProvider.userId),
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if(snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        else if(snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!;
          List<PostModel> postList = data['posts'];
          UserModel user = data['user'];
          Map<String, int> quantity = data['quantity'];
          bool isFollow = data['is_follow'];
          profileProvider.isFollow = isFollow;
          profileProvider.followers = quantity['followers']!;

          return Scaffold(
            backgroundColor: kColorsWhite,
            appBar: AppBar(
              centerTitle: profileProvider.isCurrentUser ? false : true,
              shape: const Border(
                bottom: BorderSide(
                  color: kColorsLightGrey,
                  width: kAppbarBorderWidth
                )
              ),
              elevation: 0,
              toolbarHeight: 60,
              title: Text(user.username, style: profileProvider.isCurrentUser ? Theme.of(context).textTheme.headline1 : Theme.of(context).textTheme.subtitle1),
              iconTheme: Theme.of(context).iconTheme,
              backgroundColor: kColorsWhite,
              automaticallyImplyLeading: profileProvider.isCurrentUser ? false : true,
              leading: profileProvider.isCurrentUser ? null : IconButton(
                icon: SvgPicture.asset('assets/icons/o3_back_1.svg', color: kColorsBlack),
                onPressed: (){
                  if (profileProvider.route == '/social_search') {
                    Navigator.pushNamed(context, '/social_search');
                  } else {
                    dashboardProvider.setCurrentIndex(2);
                    Navigator.pushNamed(context, '/dashboard');
                  }
                },
              ),
              actions: profileProvider.isCurrentUser ? [
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
                profileBody(context, user, profileProvider, quantity, isFollow),
                const SizedBox(height: 22),
                lineWidget(),
                allPostBody(postList, profileProvider)
              ],
            ),
          );
        }
        else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget profileBody(context, UserModel user, ProfileProvider profileProvider, Map<String, int> quantity, bool isFollow) {
    return Consumer<ProfileProvider>(
      builder: (_, value, __) {
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
                      profileProvider.isCurrentUser ? Container()
                      : profileProvider.isFollow ? ButtonWidget(
                        name: 'Unfollow',
                        isSmall: true,
                        isLight: true,
                        onTap: () {
                          FollowerController().unfollow(user.id);
                          profileProvider.setIsFollow(false);
                          profileProvider.setFollowers(profileProvider.followers - 1);
                        }
                      ) : ButtonWidget(
                        name: 'Follow',
                        isSmall: true,
                        onTap: () {
                          FollowerController().addFollow(user.id);
                          profileProvider.setIsFollow(true);
                          profileProvider.setFollowers(profileProvider.followers + 1);
                        }
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 60,
                    child: Column(
                      children: [
                        Text(quantity['posts'].toString(), style: Theme.of(context).textTheme.headline2),
                        const SizedBox(height: 11),
                        const Text('Posts', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: kColorsDarkGrey)),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Column(
                      children: [
                        Text(profileProvider.followers.toString(), style: Theme.of(context).textTheme.headline2),
                        const SizedBox(height: 11),
                        const Text('Followers', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: kColorsDarkGrey)),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Column(
                      children: [
                        Text(quantity['following'].toString(), style: Theme.of(context).textTheme.headline2),
                        const SizedBox(height: 11),
                        const Text('Following', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: kColorsDarkGrey)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }
    );
  }

  Widget allPostBody(List<PostModel> postList, ProfileProvider profileProvider) {
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
              Navigator.pushNamed(context, '/social_post_info', arguments: {"id": post.id, "route": '/profile', "isCurrentUser": profileProvider.isCurrentUser});
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