import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/outfit/models/outfit_model.dart';
import 'package:chom_tu/features/outfit/providers/outfit_controller.dart';
import 'package:chom_tu/features/outfit/providers/outfit_filter_tab_provider.dart';
import 'package:chom_tu/features/outfit/providers/outfit_tab_status_provider.dart';
import 'package:chom_tu/features/outfit/widgets/outfit_sort_filter_tab.dart';
import 'package:chom_tu/features/outfit/widgets/outfit_style_filter_tab.dart';
import 'package:chom_tu/common_widgets/filter_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class OutfitScreen extends StatelessWidget {
  const OutfitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var filterTab = Provider.of<OutfitFilterTabProvider>(context, listen: true);
    var tabStatus = Provider.of<OutfitTabStatusProvider>(context, listen: false);
    
    return Scaffold(
      backgroundColor: kColorsWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shape: const Border(
          bottom: BorderSide(
            color: kColorsLightGrey,
            width: kAppbarBorderWidth
          )
        ),
        elevation: 0,
        toolbarHeight: 60,
        centerTitle: true,
        title: Text('Outfit', style: Theme.of(context).textTheme.headline1),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        bottom: filterBar(context, tabStatus),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/outfit_create');
            },
            icon: SvgPicture.asset('assets/icons/a1_add_1.svg', color: kColorsBlack)
          ),
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/outfit_favorite');
            },
            icon: SvgPicture.asset('assets/icons/a1_heart_1.svg', color: kColorsBlack)
          )
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: OutfitController().getAllOutfits(filterTab.sort, filterTab.styles),
            builder: (BuildContext context, AsyncSnapshot<List<OutfitModel>> snapshot) {
              if(snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              else if(snapshot.connectionState == ConnectionState.done) {
                List<OutfitModel> outfitList = snapshot.data!;
                return outfitBody(outfitList);
              }
              else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),

          Consumer<OutfitTabStatusProvider>(
            builder: (_, value, __) {
              return tabStatus.status ?
                SizedBox(
                  height: double.infinity,
                  child: Column(
                    children: [
                      // Create Filter Area
                      tabStatus.indexTab == 0 ? Container(
                        height: MediaQuery.of(context).size.width * 0.29,
                        color: kColorsWhite,
                        child: filterTabContent([], context)[0],
                      )
                      : FutureBuilder(
                        future: OutfitController().getStyle(2),
                        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                          if(snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          }
                          else if(snapshot.connectionState == ConnectionState.done) {
                            List<String> styles = snapshot.data!;
                            return Container(
                              height: MediaQuery.of(context).size.width * 0.5,
                              color: kColorsWhite,
                              child: filterTabContent(styles, context)[1],
                            );
                          }
                          else {
                            return Container(
                              height: MediaQuery.of(context).size.width * 0.5,
                              color: kColorsWhite
                            );
                          }
                        },
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            tabStatus.tab(tabStatus.indexTab);
                          },
                          child: Container(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        )
                      )
                    ],
                  ),
                )
              : Container();
            }
          )
        ],
      )
    );
  }

  // Create Filter Bar
  PreferredSize filterBar(context, OutfitTabStatusProvider tabStatus) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Container(
        height: 60,
        width: double.infinity,
        color: Colors.white,
        child: Consumer<OutfitTabStatusProvider>(
          builder: (_, value, __) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    tabStatus.tab(0);
                  },
                  child: tabStatus.indexTab == 0 && tabStatus.status == true ? const FilterBarWidget(title: 'Sort', status: true) : const FilterBarWidget(title: 'Sort', status: false)
                ),
                InkWell(
                  onTap: () {
                    tabStatus.tab(1);
                  },
                  child: tabStatus.indexTab == 1 && tabStatus.status == true ? const FilterBarWidget(title: 'Style', status: true) : const FilterBarWidget(title: 'Style', status: false)
                )
              ],
            );
          }
        )
      ),
    );
  }

  Widget outfitBody(List<OutfitModel> outfitList) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: GridView.builder(
        itemCount: outfitList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1
        ),
        itemBuilder: (BuildContext context, int index) {
          OutfitModel outfit = outfitList[index];

          return Padding(
            padding: const EdgeInsets.only(left: 1, right: 1, bottom: 2),
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/outfit_info', arguments: {"id": outfit.id, "route": '/outfit'});
                  },
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(outfit.outfitImg!),
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
                    icon: outfit.isFavorite! ?
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

  List<Widget> filterTabContent(styles, context) {
    List<Widget> filterTabContent = [
      outfitSortFilterTab(context),
      outfitStyleFilterTab(context, styles),
    ];
    return filterTabContent;
  }
}