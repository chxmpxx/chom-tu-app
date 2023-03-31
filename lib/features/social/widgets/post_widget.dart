import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/auth/models/user_model.dart';
import 'package:chom_tu/features/dashboard/dashboard_provider.dart';
import 'package:chom_tu/features/profile/provider/profile_provider.dart';
import 'package:chom_tu/features/social/models/post_model.dart';
import 'package:chom_tu/features/social/provider/like_controller.dart';
import 'package:chom_tu/features/social/provider/post_controller.dart';
import 'package:chom_tu/features/social/provider/post_provider.dart';
import 'package:chom_tu/features/social/widgets/post_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatelessWidget {
  PostModel post;
  UserModel user;
  final String route;
  bool isCurrentUser;
  PostWidget({Key? key, required this.post, required this.user, required this.route, this.isCurrentUser = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var postProvider = Provider.of<PostProvider>(context, listen: false);
    var dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 22, bottom: 11, left: 22, right: 22),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  profileProvider.setProfile(isCurrentUser, user.id);
                  profileProvider.setRoute('/social');
                  dashboardProvider.setCurrentIndex(4);
                  Navigator.pushNamed(context, '/dashboard');
                },
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
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
                    const SizedBox(width: 9),
                    Text(user.username, style: Theme.of(context).textTheme.subtitle2),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () async {
                            post = await PostController().getOnePost(post.id);
                            if (isCurrentUser) {
                              // set for edit post
                              postProvider.setPostImage(post.postImg);
                              postProvider.setCaption(post.caption);
                            }
                            postBottomSheetWidget(context, post, route, isCurrentUser);
                          },
                          child: SvgPicture.asset('assets/icons/o6_more_1.svg')
                        )
                      )
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 11),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(post.caption ?? '', style: Theme.of(context).textTheme.bodyText1)
              ),
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(post.postImg!),
                fit: BoxFit.cover,
              ),
            ),
          )
        ),
        Padding(
          padding: const EdgeInsets.only(left: 22, bottom: 11),
          child: Consumer<PostProvider>(
            builder: (_, value, __) {
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 11),
                    child: InkWell(
                      onTap: () async {
                        if (post.isLike!) {
                          // Unlike
                          await LikeController().unlike(post.id);
                        } else {
                          // Like
                          var data = {"post_id": post.id};
                          await LikeController().addLike(data);
                        }
                        post = await PostController().getOnePost(post.id);
                        postProvider.setPostId(post.id);
                      },
                      child: post.isLike! ? SvgPicture.asset('assets/icons/o6_like_2.svg') : SvgPicture.asset('assets/icons/o6_like_1.svg')
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 17),
                    child: Text('  ${post.likes} Likes', style: Theme.of(context).textTheme.bodyText1),
                  )
                ],
              );
            }
          )
        ),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width,
          color: kColorsLightGrey
        ),
      ],
    );
  }
}