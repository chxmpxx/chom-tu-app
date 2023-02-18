import 'package:chom_tu/common_widgets/filter_bar_widget.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/admin/providers/admin_report_filter_tab_provider.dart';
import 'package:chom_tu/features/admin/widgets/admin_drawer_widget.dart';
import 'package:chom_tu/features/admin/widgets/report_bottom_sheet_widget.dart';
import 'package:chom_tu/features/admin/widgets/report_detail_filter_tab_widget.dart';
import 'package:chom_tu/features/admin/widgets/report_sort_filter_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AdminReportScreen extends StatelessWidget {
  const AdminReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var filterTab = Provider.of<AdminReportFilterTabProvider>(context, listen: true);
    
    List<Widget> filterTabContent = [
      reportSortFilterTab(context),
      reportDetailFilterTab(context)
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
        title: Text('Report', style: Theme.of(context).textTheme.subtitle1),
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
                      width: 94,
                      child: Row(
                        children: [
                          const SizedBox(width: 34),
                          Text('Owner', style: Theme.of(context).textTheme.subtitle2),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 135,
                      child: Text('Detail', style: Theme.of(context).textTheme.subtitle2)
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 60,
                      child: Text('Manage', style: Theme.of(context).textTheme.subtitle2)
                    )
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
                                  color: kColorsGrey
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 60,
                                child: Text('Nong._', style: Theme.of(context).textTheme.bodyText1, overflow: TextOverflow.ellipsis)
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 135,
                            child: Text('My Intellectual property', style: Theme.of(context).textTheme.bodyText1)
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 60,
                            child: InkWell(
                              onTap: (){
                                reportBottomSheetWidget(context);
                              },
                              child: SvgPicture.asset('assets/icons/o6_more_1.svg')
                            )
                          )
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
                                  color: kColorsGrey
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 60,
                                child: Text('Miso.love', style: Theme.of(context).textTheme.bodyText1, overflow: TextOverflow.ellipsis)
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 60,
                            child: Text('Spam', style: Theme.of(context).textTheme.bodyText1)
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 60,
                            child: InkWell(
                              onTap: (){
                                reportBottomSheetWidget(context);
                              },
                              child: SvgPicture.asset('assets/icons/o6_more_1.svg')
                            )
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
      ),
    );
  }

  // Create Filter Bar
  PreferredSize filterBar(context, AdminReportFilterTabProvider filterTab) {
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
              child: filterTab.indexTab == 1 && filterTab.tabStatus == true ? const FilterBarWidget(title: 'Detail', status: true) : const FilterBarWidget(title: 'Detail', status: false)
            )
          ],
        ),
      ),
    );
  }
}