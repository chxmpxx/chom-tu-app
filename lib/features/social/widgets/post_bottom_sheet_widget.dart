import 'package:chom_tu/common_widgets/line_sheet_widget.dart';
import 'package:chom_tu/common_widgets/show_dialog_widget.dart';
import 'package:chom_tu/common_widgets/bottom_sheet_menu_widget.dart';
import 'package:chom_tu/features/dashboard/dashboard_provider.dart';
import 'package:chom_tu/features/social/models/post_model.dart';
import 'package:chom_tu/features/social/provider/post_controller.dart';
import 'package:chom_tu/features/social/provider/post_provider.dart';
import 'package:chom_tu/features/social/provider/saved_post_controller.dart';
import 'package:chom_tu/features/social/widgets/post_report_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> postBottomSheetWidget(BuildContext context, PostModel post, String route, [isCurrentUser = false]) {
  var postProvider = Provider.of<PostProvider>(context, listen: false);
  var dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
  
  if (route == '/social_post_info' && isCurrentUser) {
    dashboardProvider.setCurrentIndex(3);
  } else {
    dashboardProvider.setCurrentIndex(2);
  }

  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    context: context,
    builder: (BuildContext context) {
      return isCurrentUser ? Wrap(
        children: [
          BottomSheetMenuWidget(
            icon: 'assets/icons/a3_edit_1.svg',
            title: 'Edit Post',
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/social_post_caption', arguments: {"id": post.id, "route": route});
            },
          ),
          lineSheetWidget(context),
          BottomSheetMenuWidget(
            icon: 'assets/icons/o9_bin_3.svg',
            title: 'Delete Post',
            onTap: (){
              showDialogWidget(
                context, 'Delete Post', 'This post will be deleted.', 'Delete',
                () async {
                  await PostController().deletePost(post.id);
                  Navigator.pushNamed(context, '/dashboard');
                }
              );
            },
          )
        ],
      ) : 
      Wrap(
        children: [
          Consumer<PostProvider>(
            builder: (_, value, __) {
              return BottomSheetMenuWidget(
                icon: post.isSaved! ? 'assets/icons/a5_bookmark_2.svg' : 'assets/icons/a5_bookmark_1.svg',
                title: post.isSaved! ? 'Unsave Post' : 'Save Post',
                onTap: () async {
                  if (post.isSaved!) {
                    // Unsaved
                    await SavedPostController().unsavedPost(post.id);
                  } else {
                    // Saved
                    var data = {"post_id": post.id};
                    await SavedPostController().addSavedPost(data);
                  }
                  post = await PostController().getOnePost(post.id);
                  postProvider.setPostId(post.id);
                  Navigator.pop(context);
                },
              );
            }
          ),
          // lineSheetWidget(context),
          // BottomSheetMenuWidget(
          //   icon: 'assets/icons/b1_hanger_1.svg',
          //   title: 'Copy Outfit',
          //   onTap: (){},
          // ),
          lineSheetWidget(context),
          BottomSheetMenuWidget(
            icon: 'assets/icons/o8_report_1.svg',
            title: 'Repost',
            onTap: (){
              Navigator.pop(context);
              postReportBottomSheetWidget(context, post.id!);
            },
          )
        ],
      );
    }
  );
}