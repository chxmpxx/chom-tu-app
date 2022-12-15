import 'package:chom_tu/configs/themes/colors.dart';
import 'package:chom_tu/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialPostCaptionScreen extends StatelessWidget {
  const SocialPostCaptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController caption = TextEditingController();

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
            icon: SvgPicture.asset('assets/o3_back_1.svg', color: kColorsBlack),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 22, top: 22),
              child: InkWell(
                onTap: (){},
                child: Text('Share', style: Theme.of(context).textTheme.headline5)
              ),
            ),
          ],
        ),
        
        body: ListView(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: kColorsGrey
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Padding(
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
            ),
          ],
        ),
      ),
    );
  }
}