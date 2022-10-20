import 'package:chom_tu/configs/themes/constants.dart';
import 'package:chom_tu/wardrobe/providers/filter_tab_provider.dart';
import 'package:chom_tu/widgets/filter_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WardrobeScreen extends StatelessWidget {
  const WardrobeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // true: คือเรียกตลอด (เหมือน setState) false: เรียกเฉพาะตอนใช้
    var filterTab = Provider.of<FilterTabProvider>(context, listen: false);
    List<Widget> filterTabContent = [
      sortFilterTab(),
      typeFilterTab(),
      colorFilterTab()
    ];

    return Scaffold(
      backgroundColor: kColorsWhite,
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: kColorsGrey2,
            width: kAppbarBorderWidth
          )
        ),
        elevation: 0,
        toolbarHeight: 60,
        centerTitle: true,
        title: Text('Top', style: Theme.of(context).textTheme.headline1),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        leading: Builder(
          builder: (context) => IconButton(
            icon: SvgPicture.asset('assets/a1_hamburger_1.svg', color: kColorsBlack),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        bottom: filterBar(context, filterTab),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/wardrobe_camera');
            },
            icon: SvgPicture.asset('assets/a1_camera_1.svg', color: kColorsBlack)
          ),
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset('assets/a1_heart_1.svg', color: kColorsBlack)
          )
        ],
      ),
      drawer: categoryDrawer(context),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Material(
              child: GridView.builder(
                itemCount: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 1, right: 1, bottom: 2),
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/wardrobe_info');
                          },
                          child: Container(
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: kColorsGrey3
                            ),
                          ),
                        ),
                        Positioned(
                          top: -10,
                          right: -10,
                          child: IconButton(
                            onPressed: (){},
                            icon: SvgPicture.asset('assets/o2_heart_1.svg')
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
          ),

          Consumer<FilterTabProvider>(
            builder: (_, value, __) {
              return filterTab.tabStatus ?
                Container(
                  height: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.34,
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
              : Container();
            }
          )
          
        ],
      )
    );
  }

  // Create Category Drawer
  Widget categoryDrawer(context) {
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
                      child: Text('Category', style: Theme.of(context).textTheme.headline2),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: SvgPicture.asset('assets/o1_false_1.svg', color: kColorsBlack)
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SvgPicture.asset('assets/a2_top_1.svg', color: kColorsWhite),
                ),
                title: Text('Tops', style: Theme.of(context).textTheme.subtitle2),
                tileColor: kColorsBlack,
                onTap: (){
                  // Navigator.pop(context);
                  // Navigator.pushNamed(context, '/');
                },
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SvgPicture.asset('assets/a2_bottom_1.svg', color: kColorsBlack),
                ),
                title: Text('Bottoms', style: Theme.of(context).textTheme.subtitle1),
                onTap: (){
                  // Navigator.pop(context);
                  // Navigator.pushNamed(context, '/');
                },
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SvgPicture.asset('assets/a2_set_1.svg', color: kColorsBlack),
                ),
                title: Text('Set', style: Theme.of(context).textTheme.subtitle1),
                onTap: (){
                  // Navigator.pop(context);
                  // Navigator.pushNamed(context, '/');
                },
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SvgPicture.asset('assets/a2_shoes_1.svg', color: kColorsBlack),
                ),
                title: Text('Shoes', style: Theme.of(context).textTheme.subtitle1),
                onTap: (){
                  // Navigator.pop(context);
                  // Navigator.pushNamed(context, '/');
                },
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SvgPicture.asset('assets/a2_bag_1.svg', color: kColorsBlack),
                ),
                title: Text('Accessory', style: Theme.of(context).textTheme.subtitle1),
                onTap: (){
                  // Navigator.pop(context);
                  // Navigator.pushNamed(context, '/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Create Filter Bar
  PreferredSize filterBar(context, FilterTabProvider filterTab) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Container(
        height: 60,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Consumer<FilterTabProvider>(
              builder: (_, value, __) {
                return Container(
                  child: InkWell(
                    onTap: () {
                      filterTab.filterTab(0);
                    },
                    child: filterTab.indexTab == 0 && filterTab.tabStatus == true ? FilterBarWidget(title: 'Sort', status: true) : FilterBarWidget(title: 'Sort', status: false)
                  ),
                );
              }
            ),
            Consumer<FilterTabProvider>(
              builder: (_, value, __) {
                return Container(
                  child: InkWell(
                    onTap: () {
                      filterTab.filterTab(1);
                    },
                    child: filterTab.indexTab == 1 && filterTab.tabStatus == true ? FilterBarWidget(title: 'Type', status: true) : FilterBarWidget(title: 'Type', status: false)
                  ),
                );
              }
            ),
            Consumer<FilterTabProvider>(
              builder: (_, value, __) {
                return Container(
                  child: InkWell(
                    onTap: () {
                      filterTab.filterTab(2);
                    },
                    child: filterTab.indexTab == 2 && filterTab.tabStatus == true ? FilterBarWidget(title: 'Color', status: true) : FilterBarWidget(title: 'Color', status: false)
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget sortFilterTab() {
    return Center(child: Text('Sort'));
  }

  Widget typeFilterTab() {
    return Center(child: Text('Type'));
  }

  Widget colorFilterTab() {
    return Center(child: Text('Color'));
  }

}