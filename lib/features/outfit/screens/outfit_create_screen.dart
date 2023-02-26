import 'package:chom_tu/constants/data_constant.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/outfit/providers/delete_item_provider.dart';
import 'package:chom_tu/features/outfit/providers/is_delete_btn_active_provider.dart';
import 'package:chom_tu/features/outfit/providers/outfit_create_provider.dart';
import 'package:chom_tu/features/outfit/providers/show_delete_btn_provider.dart';
import 'package:chom_tu/features/outfit/widgets/color_bar_widget.dart';
import 'package:chom_tu/features/outfit/widgets/panel_widget.dart';
import 'package:chom_tu/features/outfit/widgets/type_bar_widget.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_filter_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OutfitCreateScreen extends StatefulWidget {
  const OutfitCreateScreen({Key? key}) : super(key: key);

  @override
  State<OutfitCreateScreen> createState() => _OutfitCreateScreenState();
}

class _OutfitCreateScreenState extends State<OutfitCreateScreen> {
  @override
  Widget build(BuildContext context) {

    var filterTab = Provider.of<WardrobeFilterTabProvider>(context, listen: true);
    var provider = Provider.of<OutfitCreateProvider>(context, listen: false);

    if (provider.tabStatus) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: kColorsBlack,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ));
    }

    return Material(
      child: SlidingUpPanel(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        maxHeight: provider.tabStatus ? MediaQuery.of(context).size.height * (provider.outfitIndex != 0 ? 0.55 : 0.18) : 0,
        minHeight: provider.tabStatus ? MediaQuery.of(context).size.height * (provider.outfitIndex != 0 ? 0.25 : 0.18) : 0,
        header: buildHeader(context, provider, filterTab),
        panelBuilder: (controller) {
          return Padding(
            padding: const EdgeInsets.only(top: 135),
            child: provider.outfitIndex != 0 ? PanelWidget(controller: controller) : Container(),
          );
        },
        body: SafeArea(
          child: Scaffold(
            backgroundColor: provider.tabStatus ? kColorsBlack : kColorsWhite,
            appBar: provider.tabStatus ? null : AppBar(
              shape: const Border(
                bottom: BorderSide(color: kColorsLightGrey, width: kAppbarBorderWidth)
              ),
              elevation: 0,
              toolbarHeight: 60,
              centerTitle: true,
              title: Text('Create', style: Theme.of(context).textTheme.headline1),
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
                    onTap: (){},
                    child: Text('Save', style: Theme.of(context).textTheme.headline5)
                  ),
                )
              ],
            ),
            bottomNavigationBar: provider.tabStatus ? null : outfitNavigationBar(context, provider, filterTab),
            body: Padding(
              padding: provider.tabStatus ? const EdgeInsets.only(top: 60) : const EdgeInsets.only(top: 0),
              child: Align(
                alignment: provider.tabStatus ? Alignment.topCenter : Alignment.center,
                child: bodyOutfitCreate(provider)
              ),
            ),
          )
        ),
      ),
    );
  }

  Widget bodyOutfitCreate(OutfitCreateProvider provider) {
    return Consumer<DeleteItemProvider>(
      builder: (_, value, __) {
        return Consumer<OutfitCreateProvider>(
          builder: (_, value, __) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: provider.backgroundColor
              ),
              child: provider.items.isNotEmpty ? Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                  ),

                  for(int i = 0; i < provider.items.length; i++) 
                  provider.items[i],

                  Consumer<ShowDeleteBtnProvider>(
                    builder: (_, value, __) {
                      return provider.showDeleteBtn ?
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Consumer<IsDeleteBtnActiveProvider>(
                            builder: (_, value, __) {
                              return provider.isDeleteBtnActive ? SvgPicture.asset('assets/icons/o5_bin_2.svg')
                              : SvgPicture.asset('assets/icons/o5_bin_1.svg');
                            }
                          )
                        )
                      )
                      : Container();
                    }
                  )
                ]
              ) : Container()
            );
          }
        );
      }
    );
  }

  Widget outfitNavigationBar(context, OutfitCreateProvider provider, WardrobeFilterTabProvider filterTab) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: kColorsWhite,
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kColorsBlack)
        )
      ),

      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          height: 75,
          width: (MediaQuery.of(context).size.width / 5) * 6,
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: kColorsLightGrey, width: kAppbarBorderWidth))
          ),
          child: NavigationBar(
            height: 75,
            backgroundColor: kColorsWhite,
            onDestinationSelected: (index) {
              setState(() {
                if (index != 0) {
                  filterTab.setCategory(category[index-1]);
                }
                provider.selectTab();
                provider.setIndex(index);
              });
            },
            destinations: [
              NavigationDestination(
                icon: SvgPicture.asset('assets/icons/a2_bg_1.svg', color: kColorsBlack),
                label: 'Background',
              ),
              NavigationDestination(
                icon: SvgPicture.asset('assets/icons/a2_top_1.svg', color: kColorsBlack),
                label: 'Tops',
              ),
              NavigationDestination(
                icon: SvgPicture.asset('assets/icons/a2_bottom_1.svg', color: kColorsBlack),
                label: 'Bottoms',
              ),
              NavigationDestination(
                icon: SvgPicture.asset('assets/icons/a2_set_1.svg', color: kColorsBlack),
                label: 'Set',
              ),
              NavigationDestination(
                icon: SvgPicture.asset('assets/icons/a2_shoes_1.svg', color: kColorsBlack),
                label: 'Shoes',
              ),
              NavigationDestination(
                icon: SvgPicture.asset('assets/icons/a2_bag_1.svg', color: kColorsBlack),
                label: 'Accessory',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(context, outfitProvider, filterTab) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: outfitProvider.outfitIndex != 0 ? 145 : 115,
      child: Column(
        children: [
          buildMenu(outfitProvider, filterTab),
          Padding(
            padding: EdgeInsets.only(top: outfitProvider.outfitIndex != 2 ? 10 : 20, left: 20),
            child: Column(
              children: [
                outfitProvider.outfitIndex != 0 ? TypeBarWidget(outfitProvider: outfitProvider) : Container(),
                const SizedBox(height: 5),
                Consumer<OutfitCreateProvider>(
                  builder: (_, value, __) {
                    return ColorBarWidget(outfitProvider: outfitProvider);
                  }
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenu(OutfitCreateProvider outfitProvider, WardrobeFilterTabProvider filterTab) {
    List<String> menu = ['Background', 'Top', 'Bottom', 'Set', 'Shoes', 'Accessory'];

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: outfitProvider.outfitIndex != 2 ? kColorsWhite : kColorsLightGrey,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  if (outfitProvider.outfitIndex != 0) {
                    outfitProvider.notConfirmWardrobe(context);
                  }else {
                    outfitProvider.notConfirmBackground();
                  }
                  
                  outfitProvider.selectTab();
                  resetFilterTab(filterTab);
                });
              },
              child: SvgPicture.asset('assets/icons/o1_false_1.svg', color: kColorsBlack)
            ),
            outfitProvider.outfitIndex != 2 ? Text(menu[outfitProvider.outfitIndex], style: Theme.of(context).textTheme.headline2)
            : Row(
              children: [
                ...List.generate(bottomTypes.length, (index) {
                  return InkWell(
                    onTap: (){
                      setState(() {
                        resetFilterTab(filterTab);
                        filterTab.setBottom(bottomTypes[index]);
                        outfitProvider.setBottomIndex(index);
                      });
                    },
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        alignment: Alignment.center,
                        height: 52,
                        width: 83,
                        decoration: BoxDecoration(
                          color: outfitProvider.bottomIndex == index ? kColorsWhite : kColorsLightGrey,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                        ),
                        child: Text(bottomTypes[index], style: outfitProvider.bottomIndex == index ? Theme.of(context).textTheme.headline2 : Theme.of(context).textTheme.headline6),
                      ),
                    ),
                  );
                })
              ],
            ),
            InkWell(
              onTap: () {
                setState(() {
                  if (outfitProvider.outfitIndex != 0) {
                    outfitProvider.confirmWardrobe();
                  }else {
                    outfitProvider.confirmBackground();
                  }

                  outfitProvider.selectTab();
                  resetFilterTab(filterTab);
                });
              },
              child: SvgPicture.asset('assets/icons/o1_true_1.svg', color: kColorsBlack)
            ),
          ],
        ),
      ),
    );
  }

  void resetFilterTab(filterTab) {
    filterTab.removeAllTypes();
    filterTab.removeAllBottomTypes();
    filterTab.removeAllColors();
  }

}