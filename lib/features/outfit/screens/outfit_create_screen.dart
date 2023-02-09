import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/outfit/providers/delete_item_provider.dart';
import 'package:chom_tu/features/outfit/providers/is_delete_btn_active_provider.dart';
import 'package:chom_tu/features/outfit/providers/outfit_create_provider.dart';
import 'package:chom_tu/features/outfit/providers/show_delete_btn_provider.dart';
import 'package:chom_tu/features/outfit/widgets/color_bar_widget.dart';
import 'package:chom_tu/features/outfit/widgets/panel_widget.dart';
import 'package:chom_tu/features/outfit/widgets/type_bar_widget.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
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
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarBrightness: Brightness.dark,
    //   statusBarIconBrightness: Brightness.light,
    //   statusBarColor: Colors.transparent,
    // ));

    var provider = Provider.of<OutfitCreateProvider>(context, listen: false);

    return Material(
      child: SlidingUpPanel(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        maxHeight: provider.tabStatus ? MediaQuery.of(context).size.height * 0.55 : 0,
        minHeight: provider.tabStatus ? MediaQuery.of(context).size.height * 0.25 : 0,
        header: buildHeader(context),
        panelBuilder: (controller) {
          return Padding(
            padding: const EdgeInsets.only(top: 135),
            child: PanelWidget(controller: controller),
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
                IconButton(
                  onPressed: (){},
                  icon: SvgPicture.asset('assets/icons/o1_save_1.svg', color: kColorsBlack)
                ),
                IconButton(
                  onPressed: (){},
                  icon: SvgPicture.asset('assets/icons/o1_true_1.svg', color: kColorsBlack)
                )
              ],
            ),
            bottomNavigationBar: provider.tabStatus ? null : outfitNavigationBar(context, provider),
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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: kColorsGrey
      ),
      child: Consumer<DeleteItemProvider>(
        builder: (_, value, __) {
          return Consumer<OutfitCreateProvider>(
            builder: (_, value, __) {
              return provider.items.isNotEmpty ? Stack(
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
              ) : Container();
            }
          );
        }
      )
    );
  }

  Widget outfitNavigationBar(context, OutfitCreateProvider provider) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: kColorsWhite,
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kColorsBlack)
        )
      ),

      child: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: kColorsLightGrey, width: kAppbarBorderWidth))
        ),
        child: NavigationBar(
          height: 75,
          backgroundColor: kColorsWhite,
          onDestinationSelected: (index) {
            setState(() {
              provider.selectTab();
            });
          },
          destinations: [
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
    );
  }

  Widget buildHeader(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 135,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: Column(
          children: [
            buildMenu(context),
            const SizedBox(height: 25),
            const TypeBarWidget(),
            const SizedBox(height: 5),
            const ColorBarWidget(),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget buildMenu(context) {
    var provider = Provider.of<OutfitCreateProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                // todo: create previous item
                provider.items = [];
                provider.selectTab();
              });
            },
            child: SvgPicture.asset('assets/icons/o1_false_1.svg', color: kColorsBlack)
          ),
          Text('Top', style: Theme.of(context).textTheme.headline2),
          InkWell(
            onTap: () {
              setState(() {
                provider.selectTab();
              });
            },
            child: SvgPicture.asset('assets/icons/o1_true_1.svg', color: kColorsBlack)
          ),
        ],
      ),
    );
  }

}