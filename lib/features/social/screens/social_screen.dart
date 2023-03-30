import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/social/models/post_model.dart';
import 'package:chom_tu/features/social/provider/post_controller.dart';
import 'package:chom_tu/features/social/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({Key? key}) : super(key: key);

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
        title: Text('ChomTu', style: Theme.of(context).textTheme.headline1),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/social_post');
            },
            icon: SvgPicture.asset('assets/icons/a1_add_1.svg', color: kColorsBlack)
          ),
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/social_search');
            },
            icon: SvgPicture.asset('assets/icons/a5_search_1.svg')
          )
        ],
      ),
      body: FutureBuilder(
        future: PostController().getAllPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<PostModel>> snapshot) {
          if(snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          else if(snapshot.connectionState == ConnectionState.done) {
            List<PostModel> postList = snapshot.data!;
            return ListView.builder(
              itemCount: postList.length,
              itemBuilder: (BuildContext context, int index) {
                PostModel post = postList[index];
                return PostWidget(post: post, route: '/dashboard');
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
    );
  }
}