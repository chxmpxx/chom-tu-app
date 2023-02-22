import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/common_widgets/filter_bar_widget.dart';
import 'package:chom_tu/features/wardrobe/models/wardrobe_model.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_controller.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_filter_tab_provider.dart';
import 'package:chom_tu/features/wardrobe/widgets/wardrobe_color_filter_tab_widget.dart';
import 'package:chom_tu/features/wardrobe/widgets/wardrobe_sort_filter_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WardrobeFavoriteScreen extends StatelessWidget {
  const WardrobeFavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var filterTab = Provider.of<WardrobeFilterTabProvider>(context, listen: true);
    
    List<Widget> filterTabContent = [
      wardrobSortFilterTab(context),
      wardrobeColorFilterTab(context)
    ];

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
        title: Text('Favorite', style: Theme.of(context).textTheme.headline1),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        bottom: filterBar(context, filterTab),
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/o3_back_1.svg', color: kColorsBlack),
          onPressed: (){
            filterTab.removeAll();
            Navigator.pushNamed(context, '/wardrobe');
          },
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: WardrobeController().getAllFavWardrobes(filterTab.sort, filterTab.colors),
            builder: (BuildContext context, AsyncSnapshot<List<WardrobeModel>> snapshot) {
              if(snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              else if(snapshot.connectionState == ConnectionState.done) {
                List<WardrobeModel> wardrobeList = snapshot.data!;
                return wardrobeFavBody(wardrobeList);
              }
              else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
    
          filterTab.tabStatus ?
            SizedBox(
              height: double.infinity,
              child: Column(
                children: [
                  // Create Filter Area
                  Container(
                    height: filterTab.indexTab == 0 ? MediaQuery.of(context).size.width * 0.28 : MediaQuery.of(context).size.width * 0.47,
                    color: kColorsWhite,
                    child: filterTabContent[filterTab.indexTab],
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        filterTab.filterTab(filterTab.indexTab);
                      },
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    )
                  )
                ],
              ),
            )
          : Container()
        ],
      )
    );
  }

  // Create Filter Bar
  PreferredSize filterBar(context, WardrobeFilterTabProvider filterTab) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Container(
        height: 60,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                filterTab.filterTab(0);
              },
              child: filterTab.indexTab == 0 && filterTab.tabStatus == true ? const FilterBarWidget(title: 'Sort', status: true) : const FilterBarWidget(title: 'Sort', status: false)
            ),
            InkWell(
              onTap: () {
                filterTab.filterTab(1);
              },
              child: filterTab.indexTab == 1 && filterTab.tabStatus == true ? const FilterBarWidget(title: 'Color', status: true) : const FilterBarWidget(title: 'Color', status: false)
            )
          ],
        ),
      ),
    );
  }

  Widget wardrobeFavBody(List<WardrobeModel> wardrobeList) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: GridView.builder(
        itemCount: wardrobeList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1
        ),
        itemBuilder: (BuildContext context, int index) {
          WardrobeModel wardrobe = wardrobeList[index];

          return Padding(
            padding: const EdgeInsets.only(left: 1, right: 1, bottom: 2),
            child: Stack(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/wardrobe_info', arguments: {"id": wardrobe.id, "route": '/wardrobe_favorite'});
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
                Positioned(
                  top: -10,
                  right: -10,
                  child: IconButton(
                    onPressed: (){},
                    icon: wardrobe.isFavorite! ?
                      SvgPicture.asset('assets/icons/o2_heart_2.svg')
                      : SvgPicture.asset('assets/icons/o2_heart_1.svg')
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}