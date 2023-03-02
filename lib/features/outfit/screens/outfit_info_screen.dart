import 'dart:convert';

import 'package:chom_tu/common_widgets/line_widget.dart';
import 'package:chom_tu/common_widgets/show_dialog_widget.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/dashboard/dashboard_provider.dart';
import 'package:chom_tu/features/outfit/models/outfit_model.dart';
import 'package:chom_tu/features/outfit/providers/outfit_controller.dart';
import 'package:chom_tu/features/outfit/providers/outfit_create_provider.dart';
import 'package:chom_tu/features/outfit/providers/outfit_fav_btn_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class OutfitInfoScreen extends StatelessWidget {
  const OutfitInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    dashboardProvider.setCurrentIndex(1);
    var outfitFavBtnProvider = Provider.of<OutfitFavBtnProvider>(context, listen: false);
    var outfitProvider = Provider.of<OutfitCreateProvider>(context, listen: false);
    Map<String, dynamic> arg = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final outfitId = arg["id"];
    late OutfitModel outfit;

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
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/o3_back_1.svg', color: kColorsBlack),
          onPressed: (){
            arg["route"] == '/outfit_favorite' ? 
            Navigator.pushNamedAndRemoveUntil(context, '/outfit_favorite', (route) => true)
            : Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => true);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialogWidget(
                context, 'Delete Photo', 'This photo will be deleted from your outfit.', 'Delete',
                () async {
                  await OutfitController().deleteOutfit(outfitId);
                  arg["route"] == '/outfit_favorite' ? 
                  Navigator.pushNamedAndRemoveUntil(context, '/outfit_favorite', (route) => true)
                  : Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => true);
                }
              );
            },
            icon: SvgPicture.asset('assets/icons/o9_bin_2.svg', color: kColorsBlack)
          ),
          IconButton(
            onPressed: (){
              outfitProvider.style = outfit.style;
              outfitProvider.detail = outfit.detail;
              outfitProvider.image = outfit.outfitImg!;
              Navigator.pushNamed(context, '/outfit_edit_info', arguments: {"id": outfit.id, "route": arg["route"]});
            },
            icon: SvgPicture.asset('assets/icons/a3_edit_1.svg', color: kColorsBlack)
          )
        ],
      ),
      body: FutureBuilder(
        future: OutfitController().getOneOutfit(outfitId),
        builder: (BuildContext context, AsyncSnapshot<OutfitModel> snapshot) {
          if(snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          else if(snapshot.connectionState == ConnectionState.done) {
            outfit = snapshot.data!;
            outfitFavBtnProvider.isFavBtn = outfit.isFavorite!;
            return outfitInfoBody(outfitId, outfit, context, outfitFavBtnProvider);
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

  Widget outfitInfoBody(outfitId, OutfitModel outfit, context, OutfitFavBtnProvider outfitFavBtnProvider) {
    return ListView(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(outfit.outfitImg!),
                fit: BoxFit.cover,
              ),
            ),
          )
        ),
        line(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(outfit.style, style: Theme.of(context).textTheme.headline1),
                  Consumer<OutfitFavBtnProvider>(
                    builder: (_, value, __) {
                      return IconButton(
                        onPressed: () async {
                          String data = jsonEncode({"userId": 2, "is_favorite": !outfitFavBtnProvider.isFavBtn});
                          await OutfitController().favOutfit(outfitId, data);
                          outfitFavBtnProvider.setIsFavBtn(!outfitFavBtnProvider.isFavBtn);
                        },
                        icon: outfitFavBtnProvider.isFavBtn ? 
                          SvgPicture.asset('assets/icons/a1_heart_2.svg', color: kColorsRed)
                          : SvgPicture.asset('assets/icons/a1_heart_1.svg', color: kColorsBlack)
                      );
                    }
                  )
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text('Detail', style: Theme.of(context).textTheme.headline2),
                  const SizedBox(width: 48),
                  Text(outfit.detail ?? 'None', style: Theme.of(context).textTheme.headline5),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

}