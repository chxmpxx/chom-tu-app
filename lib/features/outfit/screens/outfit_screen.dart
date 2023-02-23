import 'package:chom_tu/constants/themes/colors.dart';
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
    var tabStatus = Provider.of<OutfitTabStatusProvider>(context, listen: false);

    List<Widget> filterTabContent = [
      outfitSortFilterTab(context),
      outfitStyleFilterTab(context),
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
          Padding(
            padding: const EdgeInsets.all(0),
            child: Material(
              child: GridView.builder(
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 1, right: 1, bottom: 2),
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/outfit_info');
                          },
                          child: Container(
                            height: double.infinity,
                            decoration: const BoxDecoration(
                              color: kColorsGrey
                            ),
                          ),
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
            ),
          ),

          Consumer<OutfitTabStatusProvider>(
            builder: (_, value, __) {
              return tabStatus.status ?
                SizedBox(
                  height: double.infinity,
                  child: Column(
                    children: [
                      // Create Filter Area
                      Container(
                        height: tabStatus.indexTab == 0 ? MediaQuery.of(context).size.width * 0.28 : MediaQuery.of(context).size.width * 0.47,
                        color: kColorsWhite,
                        child: filterTabContent[tabStatus.indexTab],
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
}