import 'package:chom_tu/common_widgets/line_widget.dart';
import 'package:chom_tu/common_widgets/show_dialog_widget.dart';
import 'package:chom_tu/constants/data_constant.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/wardrobe/models/wardrobe_model.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_controller.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WardrobeInfoScreen extends StatelessWidget {
  const WardrobeInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var wardrobeProvider = Provider.of<WardrobeProvider>(context, listen: false);
    final wardrobeId = ModalRoute.of(context)?.settings.arguments ?? '-1';
    late WardrobeModel wardrobe;

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
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialogWidget(
                context, 'Delete Photo', 'This photo will be deleted from your wardrobe.', 'Delete',
                () async {
                  await WardrobeController().deleteWardrobe(wardrobeId);
                  Navigator.pushNamed(context, '/wardrobe');
                }
              );
            },
            icon: SvgPicture.asset('assets/icons/o9_bin_2.svg', color: kColorsBlack)
          ),
          IconButton(
            onPressed: (){
              wardrobeProvider.setData('Category', wardrobe.category);
              wardrobeProvider.setData('Sub Category', wardrobe.subCategory);
              wardrobeProvider.setData('Color', wardrobe.color);
              wardrobeProvider.setData('Type', wardrobe.type);
              wardrobeProvider.setImage(wardrobe.wardrobeImg!);
              Navigator.pushNamed(context, '/wardrobe_edit_info', arguments: wardrobe.id);
            },
            icon: SvgPicture.asset('assets/icons/a3_edit_1.svg', color: kColorsBlack)
          )
        ],
      ),
      body: FutureBuilder(
        future: WardrobeController().getOneWardrobe(wardrobeId),
        builder: (BuildContext context, AsyncSnapshot<WardrobeModel> snapshot) {
          if(snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          else if(snapshot.connectionState == ConnectionState.done) {
            wardrobe = snapshot.data!;
            final colorCode = colorCodes[colors.indexWhere((element) => element == wardrobe.color)];

            return wardrobeInfoBody(wardrobe, context, colorCode);
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

  Widget wardrobeInfoBody(WardrobeModel wardrobe, context, Color colorCode) {
    return ListView(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(wardrobe.wardrobeImg!),
                fit: BoxFit.cover,
              ),
            ),
          )
        ),
        line(context),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(wardrobe.category, style: Theme.of(context).textTheme.headline1),
                  IconButton(
                    onPressed: (){},
                    icon: SvgPicture.asset('assets/icons/a1_heart_2.svg', color: kColorsRed)
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text('Color', style: Theme.of(context).textTheme.headline2),
                  const SizedBox(width: 51),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: colorCode,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      border: Border.all(color: kColorsLightGrey)
                    ),
                  ),
                  Text('  ${wardrobe.color}', style: Theme.of(context).textTheme.headline5),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text('Type', style: Theme.of(context).textTheme.headline2),
                  const SizedBox(width: 54),
                  Text(wardrobe.type, style: Theme.of(context).textTheme.headline5),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}