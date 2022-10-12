import 'package:chom_tu/configs/themes/constants.dart';
import 'package:chom_tu/outfit/providers/outfit_create_provider.dart';
import 'package:chom_tu/outfit/widgets/color_bar_widget.dart';
import 'package:chom_tu/outfit/widgets/panel_widget.dart';
import 'package:chom_tu/outfit/widgets/type_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OutfitCreateScreen extends StatefulWidget {
  OutfitCreateScreen({Key? key}) : super(key: key);

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

    var selectTab = Provider.of<OutfitCreateProvider>(context, listen: false);
    
    return selectTab.tabStatus ? 
      Material(
        child: SlidingUpPanel(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          maxHeight: MediaQuery.of(context).size.height * 0.55,
          minHeight: MediaQuery.of(context).size.height * 0.25,
          header: buildHeader(context),
          panelBuilder: (controller) {
            return Padding(
              padding: const EdgeInsets.only(top: 135),
              child: PanelWidget(controller: controller),
            );
          },
          body: SafeArea(
            child: Scaffold(
              backgroundColor: kColorsBlack,
              body: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: kColorsGrey3
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    : Scaffold(
      backgroundColor: kColorsWhite,
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(color: kColorsGrey2, width: kAppbarBorderWidth)
        ),
        elevation: 0,
        toolbarHeight: 60,
        centerTitle: true,
        title: Text('Create', style: Theme.of(context).textTheme.headline1),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        leading: IconButton(
          icon: SvgPicture.asset('assets/o3_back_1.svg', color: kColorsBlack),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset('assets/o1_save_1.svg', color: kColorsBlack)
          ),
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset('assets/o1_true_1.svg', color: kColorsBlack)
          )
        ],
      ),
      bottomNavigationBar: outfitNavigationBar(context, selectTab),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: kColorsGrey3
          ),
        ),
      ),
    );
  }

  Widget outfitNavigationBar(context, OutfitCreateProvider selectTab) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: kColorsWhite,
        labelTextStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)
        )
      ),

      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: kColorsGrey2, width: kAppbarBorderWidth))
        ),
        child: NavigationBar(
          height: 75,
          backgroundColor: kColorsWhite,
          onDestinationSelected: (index) {
            setState(() {
              selectTab.SelectTab();
            });
          },
          destinations: [
            NavigationDestination(
              icon: SvgPicture.asset('assets/a2_top_1.svg', color: kColorsBlack),
              label: 'Tops',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('assets/a2_bottom_1.svg', color: kColorsBlack),
              label: 'Bottoms',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('assets/a2_set_1.svg', color: kColorsBlack),
              label: 'Set',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('assets/a2_shoes_1.svg', color: kColorsBlack),
              label: 'Shoes',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('assets/a2_bag_1.svg', color: kColorsBlack),
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
            SizedBox(height: 25),
            TypeBarWidget(),
            SizedBox(height: 5),
            ColorBarWidget(),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget buildMenu(context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset('assets/o1_false_1.svg', color: kColorsBlack),
          Text('Top', style: Theme.of(context).textTheme.headline4),
          SvgPicture.asset('assets/o1_true_1.svg', color: kColorsBlack),
        ],
      ),
    );
  }

}