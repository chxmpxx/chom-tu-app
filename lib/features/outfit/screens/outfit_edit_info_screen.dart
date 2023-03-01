import 'dart:io';

import 'package:chom_tu/common_widgets/line_widget.dart';
import 'package:chom_tu/common_widgets/text_form_field_widget.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/outfit/models/outfit_model.dart';
import 'package:chom_tu/features/outfit/providers/outfit_controller.dart';
import 'package:chom_tu/features/outfit/providers/outfit_create_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class OutfitEditInfoScreen extends StatelessWidget {
  const OutfitEditInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var outfitProvider = Provider.of<OutfitCreateProvider>(context, listen: false);
    final formKey = GlobalKey<FormState>();
    TextEditingController style = TextEditingController();
    TextEditingController detail = TextEditingController();

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
          title: Text('Info', style: Theme.of(context).textTheme.headline1),
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
                  OutfitModel data = OutfitModel(userId: 2, style: style.value.text, detail: detail.value.text, bgColor: outfitProvider.backgroundColor.toString());
                  if(formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    await OutfitController().addOutfit(data, outfitProvider.imagePath, outfitProvider.itemsOffsets);
                    Navigator.pushNamedAndRemoveUntil(context, '/outfit', (route) => false);
                  }
                },
                child: Text('Save', style: Theme.of(context).textTheme.headline5)
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
                child: SizedBox(
                  width: double.infinity,
                  child: Image.file(File(outfitProvider.imagePath!), fit: BoxFit.fill)
                )
              ),
              line(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 93, child: Text("Style", style: Theme.of(context).textTheme.headline2)),
                        Expanded(child: TextFormFieldWidget(controller: style, hintText: "Style", validator: "Please enter style")),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 93, child: Text("Detail", style: Theme.of(context).textTheme.headline2)),
                        Expanded(child: TextFormFieldWidget(controller: detail, hintText: "Detail", validator: "Please enter detail")),
                      ],
                    ),
                    const SizedBox(height: 10)
                  ],
                )
              )
            ],
          ),
        )
      ),
    );
  }
}