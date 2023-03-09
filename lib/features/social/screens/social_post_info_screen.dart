import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/dashboard/dashboard_provider.dart';
import 'package:chom_tu/features/social/models/post_model.dart';
import 'package:chom_tu/features/social/provider/post_controller.dart';
import 'package:chom_tu/features/social/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SocialPostInfoScreen extends StatelessWidget {
  const SocialPostInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arg = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int postId = arg["id"] as int;
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
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/o3_back_1.svg', color: kColorsBlack),
          onPressed: (){
            if (arg["route"] == '/profile') {
              Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => true);
            } else {
              Navigator.pushNamedAndRemoveUntil(context, arg["route"], (route) => true);
            }
          },
        ),
      ),
      body: FutureBuilder(
        future: PostController().getOnePost(postId),
        builder: (BuildContext context, AsyncSnapshot<PostModel> snapshot) {
          if(snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          else if(snapshot.connectionState == ConnectionState.done) {
            PostModel post = snapshot.data!;
            return PostWidget(post: post, userId: 2, route: '/social_post_info');
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