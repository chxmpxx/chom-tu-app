import 'package:chom_tu/common_widgets/filter_bar_widget.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/admin/providers/admin_user_filter_tab_provider.dart';
import 'package:chom_tu/features/admin/widgets/admin_drawer_widget.dart';
import 'package:chom_tu/features/admin/widgets/user_charges_filter_tab_widget.dart';
import 'package:chom_tu/features/admin/widgets/user_sort_filter_tab_widget.dart';
import 'package:chom_tu/features/admin/widgets/user_status_filter_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AdminUserScreen extends StatelessWidget {
  const AdminUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var filterTab = Provider.of<AdminUserFilterTabProvider>(context, listen: true);
    
    List<Widget> filterTabContent = [
      userSortFilterTab(context),
      userChargesFilterTab(context),
      userStatusFilterTab(context)
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
        title: Text('User', style: Theme.of(context).textTheme.subtitle1),
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
            onPressed: () async {},
            icon: SvgPicture.asset('assets/icons/a5_seach_1.svg')
          )
        ],
      ),
      drawer: adminDrawer(context),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 95,
                      child: Row(
                        children: [
                          const SizedBox(width: 34),
                          Text('Username', style: Theme.of(context).textTheme.subtitle2),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 60,
                      child: Text('Status', style: Theme.of(context).textTheme.subtitle2)
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 60,
                      child: Text('Charges', style: Theme.of(context).textTheme.subtitle2)
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 60,
                      child: Text('Ban', style: Theme.of(context).textTheme.subtitle2)
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  color: kColorsGrey,
                                  borderRadius: BorderRadius.all(Radius.circular(24)),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 61,
                                child: Text('Chxm.xoxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', style: Theme.of(context).textTheme.bodyText1, overflow: TextOverflow.ellipsis)
                              ),
                            ],
                          ),
                          //todo: if status == banned -> red
                          Container(
                            alignment: Alignment.center,
                            width: 60,
                            child: Text('Active', style: Theme.of(context).textTheme.bodyText1)
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 60,
                            child: Text('3', style: Theme.of(context).textTheme.bodyText1)
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 24,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: kColorsBlack,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Text('Unban', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: kColorsWhite)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  color: kColorsGrey,
                                  borderRadius: BorderRadius.all(Radius.circular(24)),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 60,
                                child: Text('Miso', style: Theme.of(context).textTheme.bodyText1, overflow: TextOverflow.ellipsis)
                              ),
                            ],
                          ),
                          //todo: if status == banned -> red
                          Container(
                            alignment: Alignment.center,
                            width: 60,
                            child: const Text('Banned', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: kColorsRed))
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 60,
                            child: Text('54', style: Theme.of(context).textTheme.bodyText1)
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 24,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: kColorsBlack,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Text('Ban', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: kColorsWhite)),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          filterTab.tabStatus ?
            SizedBox(
              height: double.infinity,
              child: Column(
                children: [
                  // Create Filter Area
                  Container(
                    height: MediaQuery.of(context).size.width * 0.28,
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
      ),
    );
  }

  // Create Filter Bar
  PreferredSize filterBar(context, AdminUserFilterTabProvider filterTab) {
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
              child: filterTab.indexTab == 1 && filterTab.tabStatus == true ? const FilterBarWidget(title: 'Charges', status: true) : const FilterBarWidget(title: 'Charges', status: false)
            ),
            InkWell(
              onTap: () {
                filterTab.filterTab(2);
              },
              child: filterTab.indexTab == 2 && filterTab.tabStatus == true ? const FilterBarWidget(title: 'Status', status: true) : const FilterBarWidget(title: 'Status', status: false)
            )
          ],
        ),
      ),
    );
  }
}