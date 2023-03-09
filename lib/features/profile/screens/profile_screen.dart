import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/profile/widgets/setting_bottom_sheet_widget.dart';
import 'package:chom_tu/features/social/models/post_model.dart';
import 'package:chom_tu/features/social/provider/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text('Arreeya', style: Theme.of(context).textTheme.headline1),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        automaticallyImplyLeading: false,
        actions: [
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
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(22),
                child: Row(  
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width / 2) - 44,
                      height: (MediaQuery.of(context).size.width / 2) - 44,
                      decoration: BoxDecoration(
                        color: kColorsGrey,
                        borderRadius: BorderRadius.all(Radius.circular((MediaQuery.of(context).size.width / 2) - 44)),
                      ),
                    ),
                    const SizedBox(width: 22),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Chompoo', style: Theme.of(context).textTheme.headline2),
                        const SizedBox(height: 11),
                        Text('Hope you like my outfits :D', style: Theme.of(context).textTheme.subtitle2),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
                      const Text('Likes', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: kColorsDarkGrey)),
                    ],
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 22),
          FutureBuilder(
            future: PostController().getAllProfilePosts(2),
            builder: (BuildContext context, AsyncSnapshot<List<PostModel>> snapshot) {
              if(snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              else if(snapshot.connectionState == ConnectionState.done) {
                List<PostModel> postList = snapshot.data!;
                return allMyPostBody(postList);
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

  Widget allMyPostBody(List<PostModel> postList) {
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