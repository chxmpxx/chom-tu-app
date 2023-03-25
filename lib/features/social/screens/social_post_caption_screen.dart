import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/common_widgets/text_form_field_widget.dart';
import 'package:chom_tu/features/dashboard/dashboard_provider.dart';
import 'package:chom_tu/features/social/models/post_model.dart';
import 'package:chom_tu/features/social/provider/post_controller.dart';
import 'package:chom_tu/features/social/provider/post_provider.dart';
import 'package:chom_tu/utils/create_file_from_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SocialPostCaptionScreen extends StatelessWidget {
  const SocialPostCaptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arg = (ModalRoute.of(context)?.settings.arguments ?? {"id" : '-1', "route": '/None'}) as Map<String, dynamic>;
    final postId = arg["id"];

    var postProvider = Provider.of<PostProvider>(context, listen: false);
    var dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    if (arg["route"] == '/social_post_info') {
      dashboardProvider.setCurrentIndex(3);
    } else {
      dashboardProvider.setCurrentIndex(2);
    }

    final formKey = GlobalKey<FormState>();
    TextEditingController caption = TextEditingController();

    if (postId != '-1') {
      caption.text = postProvider.caption;
    }

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
          title: Text('Post', style: Theme.of(context).textTheme.headline1),
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: kColorsWhite,
          leading: IconButton(
            icon: SvgPicture.asset('assets/icons/o3_back_1.svg', color: kColorsBlack),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 22, top: 22),
              child: InkWell(
                onTap: () async {
                  if (postId == '-1') {
                    // new post (add)
                    PostModel data = PostModel(imgDetail: 'imgDetail', caption: caption.value.text);
                    String path = await createFileFromUrl(postProvider.imagePath);
                    await PostController().addPost(data, path);
                    postProvider.removePostImage();
                    Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => true);
                  } else {
                    // edit post (update)
                    await PostController().updatePost(postId, {"caption": caption.value.text});
                    Navigator.pushNamedAndRemoveUntil(context, arg["route"], (route) => true, arguments: postId);
                  }
                  
                },
                child: Text('Share', style: Theme.of(context).textTheme.headline5)
              ),
            ),
          ],
        ),
        
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(postProvider.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Row(
                  children: [
                    Text('Caption', style: Theme.of(context).textTheme.headline2),
                    const SizedBox(width: 32),
                    Expanded(
                      child: TextFormFieldWidget(controller: caption, hintText: "Write a caption...", validator: " ", isCaption: true)
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}