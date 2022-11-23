import 'dart:io';

import 'package:chom_tu/configs/themes/colors.dart';
import 'package:chom_tu/utils/remove_bg_api.dart';
import 'package:chom_tu/wardrobe/providers/edit_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WardrobeEraserScreen extends StatelessWidget {
  const WardrobeEraserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var wardrobeProvider = Provider.of<EditTabProvider>(context, listen: false);
    String imagePath;
    bool waitImage = true;

    Future<void> init() async {
      imagePath = await ApiClient().removeBgApi(wardrobeProvider.currentPath!);
      wardrobeProvider.setPath(imagePath);
      waitImage = false;
    }

    init();
    return Scaffold(
      backgroundColor: kColorsBlack,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        leading: IconButton(
          icon: SvgPicture.asset('assets/o1_false_1.svg', color: kColorsBlack),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset('assets/o1_true_1.svg', color: kColorsBlack)
          )
        ],
      ),
      body: Center(
        child: Consumer<EditTabProvider>(
          builder: (_, value, __) {
            return waitImage ? CircularProgressIndicator()
            : Container(
              color: kColorsGrey3,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: Image.file(
                File(wardrobeProvider.currentPath!),
                fit: wardrobeProvider.isGallery ? BoxFit.cover : BoxFit.fill,
              )
            );
          }
        )
      )
    );
  }
}

// class WardrobeEraserScreen extends StatefulWidget {
//   WardrobeEraserScreen({Key? key}) : super(key: key);

//   @override
//   State<WardrobeEraserScreen> createState() => _WardrobeEraserScreenState();
// }

// class _WardrobeEraserScreenState extends State<WardrobeEraserScreen> {
//   @override
//   Widget build(BuildContext context) {

//     var wardrobeProvider = Provider.of<EditTabProvider>(context, listen: false);
//     String imagePath;
//     bool waitImage = true;

//     Future<void> init() async {
//       imagePath = await ApiClient().removeBgApi(wardrobeProvider.currentPath!);
//       wardrobeProvider.setPath(imagePath);
//       waitImage = false;
//     }

//     @override
//     void initState() {
//         super.initState();
//       print('-1');
//       init();
//     }

//     return Scaffold(
//       backgroundColor: kColorsBlack,
//       appBar: AppBar(
//         elevation: 0,
//         toolbarHeight: 60,
//         iconTheme: Theme.of(context).iconTheme,
//         backgroundColor: kColorsWhite,
//         leading: IconButton(
//           icon: SvgPicture.asset('assets/o1_false_1.svg', color: kColorsBlack),
//           onPressed: (){
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           IconButton(
//             onPressed: (){},
//             icon: SvgPicture.asset('assets/o1_true_1.svg', color: kColorsBlack)
//           )
//         ],
//       ),
//       body: Center(
//         child: waitImage ? CircularProgressIndicator()
//         : Consumer<EditTabProvider>(
//           builder: (_, value, __) {
//             return Container(
//               color: kColorsGrey3,
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.width,
//               child: Image.file(
//                 File(wardrobeProvider.currentPath!),
//                 fit: wardrobeProvider.isGallery ? BoxFit.cover : BoxFit.fill,
//               )
//             );
//           }
//         )
//       )
//     );
//   }
// }