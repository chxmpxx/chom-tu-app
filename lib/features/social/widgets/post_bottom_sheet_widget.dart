import 'package:chom_tu/common_widgets/show_dialog_widget.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/common_widgets/bottom_sheet_menu_widget.dart';
import 'package:chom_tu/features/dashboard/dashboard_provider.dart';
import 'package:chom_tu/features/social/provider/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> postBottomSheetWidget(BuildContext context, int postId, String route, [isMyPost = false]) {
  var dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
  if (route == '/social_post_info') {
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
      return isMyPost ? Wrap(
        children: [
          BottomSheetMenuWidget(
            icon: 'assets/icons/a3_edit_1.svg',
            title: 'Edit Post',
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/social_post_caption', arguments: {"id": postId, "route": route});
            },
          ),
          Center(
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width - 44,
              color: kColorsLightGrey
            ),
          ),
          BottomSheetMenuWidget(
            icon: 'assets/icons/o9_bin_3.svg',
            title: 'Delete Post',
            onTap: (){
              // Navigator.pop(context);
              showDialogWidget(
                context, 'Delete Post', 'This post will be deleted.', 'Delete',
                () async {
                  await PostController().deletePost(postId);
                  Navigator.pushNamed(context, '/dashboard');
                }
              );
            },
          )
        ],
      ) : 
      Wrap(
        children: [
          BottomSheetMenuWidget(
            icon: 'assets/icons/a5_bookmark_1.svg',
            title: 'Save Post',
            onTap: (){},
          ),
          Center(
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width - 44,
              color: kColorsLightGrey
            ),
          ),
          BottomSheetMenuWidget(
            icon: 'assets/icons/b1_hanger_1.svg',
            title: 'Copy Outfit',
            onTap: (){},
          ),
          Center(
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width - 44,
              color: kColorsLightGrey
            ),
          ),
          BottomSheetMenuWidget(
            icon: 'assets/icons/o8_report_1.svg',
            title: 'Repost',
            onTap: (){},
          )
        ],
      );
    }
  );
}