import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/dashboard/dashboard_provider.dart';
import 'package:chom_tu/features/social/models/post_model.dart';
import 'package:chom_tu/features/social/provider/saved_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SocialSavedScreen extends StatelessWidget {
  const SocialSavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    dashboardProvider.setCurrentIndex(3);

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
        centerTitle: true,
        title: Text('Saved', style: Theme.of(context).textTheme.headline1),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/o3_back_1.svg', color: kColorsBlack),
          onPressed: (){
            Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => true);
          },
        ),
      ),
      body: FutureBuilder(
        future: SavedPostController().getAllSavedPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<PostModel>> snapshot) {
          if(snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          else if(snapshot.connectionState == ConnectionState.done) {
            List<PostModel> postList = snapshot.data!;
            return allSavedPostBody(postList);
          }
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }

  Widget allSavedPostBody(List<PostModel> postList) {
    return GridView.builder(
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
              Navigator.pushNamed(context, '/social_post_info', arguments: {"id": post.id, "route": '/social_saved'});
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