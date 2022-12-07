import 'package:chom_tu/configs/themes/colors.dart';
import 'package:chom_tu/widgets/filter_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OutfitScreen extends StatelessWidget {
  const OutfitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorsWhite,
      appBar: AppBar(
        shape: Border(
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
        bottom: filterTab(context),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/outfit_create');
            },
            icon: SvgPicture.asset('assets/a1_add_1.svg', color: kColorsBlack)
          ),
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset('assets/a1_heart_1.svg', color: kColorsBlack)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Material(
          child: GridView.builder(
            itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                          decoration: BoxDecoration(
                            color: kColorsGrey
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
      )
    );
  }

  // Create Filter Tab
  PreferredSize filterTab(context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Container(
        height: 60,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: InkWell(
                onTap: () {},
                child: FilterBarWidget(title: 'Sort', status: false)
              ),
            ),
            Container(
              child: InkWell(
                onTap: () {},
                child: FilterBarWidget(title: 'Style', status: false)
              ),
            ),
          ],
        ),
      ),
    );
  }
}