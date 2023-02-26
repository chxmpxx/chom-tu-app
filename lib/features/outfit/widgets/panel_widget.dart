import 'package:chom_tu/features/outfit/providers/outfit_create_provider.dart';
import 'package:chom_tu/features/wardrobe/models/wardrobe_model.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_controller.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_filter_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;

  const PanelWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var outfitProvider = Provider.of<OutfitCreateProvider>(context, listen: false);
    var filterTab = Provider.of<WardrobeFilterTabProvider>(context, listen: false);

    return Consumer<OutfitCreateProvider>(
      builder: (_, value, __) {
        return FutureBuilder(
          future: filterTab.category != 'Bottom' ? 
            WardrobeController().getAllWardrobes(filterTab.category, filterTab.colors, filterTab.types, filterTab.sort, outfitProvider.confirmList, filterTab.bottom, true)
            : WardrobeController().getAllWardrobes(filterTab.category, filterTab.colors, filterTab.bottomTypes, filterTab.sort, outfitProvider.confirmList, filterTab.bottom, true),
          builder: (BuildContext context, AsyncSnapshot<List<WardrobeModel>> snapshot) {
            if(snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            else if(snapshot.connectionState == ConnectionState.done) {
              List<WardrobeModel> wardrobeList = snapshot.data!;
              return panelBody(outfitProvider, wardrobeList);
            }
            else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      }
    );
  }

  Widget panelBody(OutfitCreateProvider outfitProvider, wardrobeList) {
    return GridView.builder(
      controller: controller,
      itemCount: wardrobeList.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1
      ),
      itemBuilder: (BuildContext context, int index) {
        WardrobeModel wardrobe = wardrobeList[index];

        return Padding(
          padding: const EdgeInsets.only(left: 1, right: 1, bottom: 2),
          child: InkWell(
            onTap: (){
              outfitProvider.selectWardrobe(wardrobe, context);
            },
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(wardrobe.wardrobeImg!),
                  fit: BoxFit.cover,
                ),
              ),
            )
          ),
        );
      }
    );
  }

}