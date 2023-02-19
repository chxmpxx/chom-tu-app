import 'dart:io';

import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/wardrobe/models/wardrobe_model.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_controller.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_filter_tab_provider.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_provider.dart';
import 'package:chom_tu/features/wardrobe/widgets/wardrobe_color_filter_tab_widget.dart';
import 'package:chom_tu/features/wardrobe/widgets/wardrobe_sort_filter_tab_widget.dart';
import 'package:chom_tu/features/wardrobe/widgets/wardrobe_type_filter_tab_widget.dart';
import 'package:chom_tu/common_widgets/filter_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WardrobeScreen extends StatelessWidget {
  const WardrobeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var filterTab = Provider.of<WardrobeFilterTabProvider>(context, listen: true);
    var wardrobeProvider = Provider.of<WardrobeProvider>(context, listen: false);
    
    List<Widget> filterTabContent = [
      wardrobSortFilterTab(context),
      wardrobeColorFilterTab(context),
      wardrobeTypeFilterTab(context)
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
        title: Text(filterTab.category, style: Theme.of(context).textTheme.headline1),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        leading: Builder(
          builder: (context) => IconButton(
            icon: SvgPicture.asset('assets/icons/a1_hamburger_1.svg', color: kColorsBlack),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        bottom: filterBar(context, filterTab),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.pushNamed(context, '/wardrobe_camera');
              filterTab.removeAll();
            },
            icon: SvgPicture.asset('assets/icons/a1_camera_1.svg', color: kColorsBlack)
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/wardrobe_favorite');
              filterTab.removeAll();
            },
            icon: SvgPicture.asset('assets/icons/a1_heart_1.svg', color: kColorsBlack)
          )
        ],
      ),
      drawer: categoryDrawer(context, filterTab),
      body: Stack(
        children: [
          FutureBuilder(
            future: WardrobeController().getAllWardrobe(filterTab.category, filterTab.colors, filterTab.types),
            builder: (BuildContext context, AsyncSnapshot<List<WardrobeModel>> snapshot) {
              if(snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              else if(snapshot.connectionState == ConnectionState.done) {
                List<WardrobeModel> wardrobeList = snapshot.data!;
                return wardrobeBody(wardrobeList, wardrobeProvider);
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

  // Create Category Drawer
  Widget categoryDrawer(context, WardrobeFilterTabProvider filterTab) {
    List<String> list = ['Top', 'Bottom', 'Set', 'Shoes', 'Accessory'];
    List<String> iconList = ['a2_top_1.svg', 'a2_bottom_1.svg', 'a2_set_1.svg', 'a2_shoes_1.svg', 'a2_bag_1.svg'];

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.67,
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Ink(
          color: kColorsWhite,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 34),
                      child: Text('Category', style: Theme.of(context).textTheme.subtitle1),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: SvgPicture.asset('assets/icons/o1_false_1.svg', color: kColorsBlack)
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  ...List.generate(list.length, (index) {
                    return ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: SvgPicture.asset('assets/icons/${iconList[index]}', color: filterTab.category == list[index] ? kColorsWhite : kColorsBlack),
                      ),
                      title: Text(list[index], style: filterTab.category == list[index] ? Theme.of(context).textTheme.headline4 : Theme.of(context).textTheme.headline5),
                      tileColor: filterTab.category == list[index] ? kColorsBlack : kColorsWhite,
                      onTap: (){
                        filterTab.removeAllFilterTab();
                        filterTab.setCategory(list[index]);
                        Navigator.pop(context);
                      },
                    );
                  })
                ]
              )
            ],
          ),
        ),
      ),
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
            ),
            InkWell(
              onTap: () {
                filterTab.filterTab(2);
              },
              child: filterTab.indexTab == 2 && filterTab.tabStatus == true ? const FilterBarWidget(title: 'Type', status: true) : const FilterBarWidget(title: 'Type', status: false)
            )
          ],
        ),
      ),
    );
  }

  Widget wardrobeBody(List<WardrobeModel> wardrobeList, WardrobeProvider wardrobeProvider) {
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
                  onTap: () {
                    Navigator.pushNamed(context, '/wardrobe_info', arguments: '${wardrobe.id}');
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
                    icon: SvgPicture.asset('assets/icons/o2_heart_1.svg')
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