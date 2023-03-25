import 'dart:io';

import 'package:chom_tu/common_widgets/line_widget.dart';
import 'package:chom_tu/common_widgets/text_form_field_widget.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/dashboard/dashboard_provider.dart';
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
    final formKey = GlobalKey<FormState>();
    var arg = (ModalRoute.of(context)?.settings.arguments ?? {"id" : '-1'}) as Map<String, dynamic>;
    final outfitId = arg["id"];

    var dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    var outfitProvider = Provider.of<OutfitCreateProvider>(context, listen: false);

    TextEditingController style = TextEditingController();
    TextEditingController detail = TextEditingController();

    if (outfitId != '-1') {
      style.text = outfitProvider.style!;
      detail.text = outfitProvider.detail!;
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
                  if(formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (outfitId == '-1') {
                      // new outfit (add)
                      OutfitModel data = OutfitModel(style: style.value.text, detail: detail.value.text, bgColor: outfitProvider.backgroundColor.toString());
                      await OutfitController().addOutfit(data, outfitProvider.imagePath, outfitProvider.itemsOffsets);
                      outfitProvider.removeAllWardrobe();
                      dashboardProvider.setCurrentIndex(1);
                      Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => true);
                    } else {
                      // edit outfit (update)
                      Map<String, String> data = {
                        "style": style.text,
                        "detail": detail.text
                      };
                      await OutfitController().updateOutfit(outfitId, data);
                      outfitProvider.removeAllWardrobe();
                      Navigator.pushNamedAndRemoveUntil(context, '/outfit_info', (route) => true, arguments: {"id": outfitId, "route": arg["route"]});
                    }
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
                  child: outfitId == '-1' ?
                    Image.file(File(outfitProvider.imagePath!), fit: BoxFit.fill)
                    : Image.network(outfitProvider.image!, fit: BoxFit.cover)
                )
              ),
              lineWidget(),
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
                        Expanded(child: TextFormFieldWidget(controller: detail, hintText: "Detail", validator: "Please enter detail", isDetail: true,)),
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