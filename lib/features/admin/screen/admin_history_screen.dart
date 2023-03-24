import 'package:chom_tu/common_widgets/filter_bar_widget.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/admin/models/report_model.dart';
import 'package:chom_tu/features/admin/providers/admin_report_filter_tab_provider.dart';
import 'package:chom_tu/features/admin/providers/admin_tab_status_provider.dart';
import 'package:chom_tu/features/admin/providers/report_controller.dart';
import 'package:chom_tu/features/admin/widgets/admin_drawer_widget.dart';
import 'package:chom_tu/features/admin/widgets/report_detail_filter_tab_widget.dart';
import 'package:chom_tu/features/admin/widgets/report_sort_filter_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AdminHistoryScreen extends StatelessWidget {
  const AdminHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var filterTab = Provider.of<AdminReportFilterTabProvider>(context, listen: true);
    var tabStatus = Provider.of<AdminTabStatusProvider>(context, listen: false);
    
    List<Widget> filterTabContent = [
      reportSortFilterTab(context),
      reportDetailFilterTab(context),
      Container()
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
        title: Text('History', style: Theme.of(context).textTheme.subtitle1),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        leading: Builder(
          builder: (context) => IconButton(
            icon: SvgPicture.asset('assets/icons/a1_hamburger_1.svg', color: kColorsBlack),
            onPressed: () {
              if (tabStatus.status) {
                tabStatus.tab(tabStatus.indexTab);
              }
              Scaffold.of(context).openDrawer();
            }
          ),
        ),
        bottom: filterBar(context, tabStatus),
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
                      alignment: Alignment.center,
                      width: 60,
                      child: Text('Owner', style: Theme.of(context).textTheme.subtitle2)
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 80,
                      child: Text('Reported By', style: Theme.of(context).textTheme.subtitle2)
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 135,
                      child: Text('Detail', style: Theme.of(context).textTheme.subtitle2)
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 60,
                      child: Text('Status', style: Theme.of(context).textTheme.subtitle2)
                    )
                  ],
                ),
                const SizedBox(height: 22),
                Expanded(
                  child: FutureBuilder(
                    future: ReportController().getAllReports(filterTab.sort, filterTab.details, 'Discard Report'),
                    builder: (BuildContext context, AsyncSnapshot<List<ReportModel>> snapshot) {
                      if(snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      else if(snapshot.connectionState == ConnectionState.done) {
                        List<ReportModel> reportList = snapshot.data!;
                        return reportBody(reportList);
                      }
                      else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),

          Consumer<AdminTabStatusProvider>(
            builder: (_, value, __) {
              return tabStatus.status ?
                SizedBox(
                  height: double.infinity,
                  child: Column(
                    children: [
                      // Create Filter Area
                      Container(
                        height: tabStatus.indexTab == 0 ? MediaQuery.of(context).size.width * 0.29 : MediaQuery.of(context).size.width * 0.5,
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
      ),
    );
  }

  // Create Filter Bar
  PreferredSize filterBar(context, AdminTabStatusProvider tabStatus) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Container(
        height: 60,
        width: double.infinity,
        color: Colors.white,
        child: Consumer<AdminTabStatusProvider>(
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
                  child: tabStatus.indexTab == 1 && tabStatus.status == true ? const FilterBarWidget(title: 'Detail', status: true) : const FilterBarWidget(title: 'Detail', status: false)
                )
              ],
            );
          }
        )
      ),
    );
  }

  Widget reportBody(List<ReportModel> reportList) {
    return ListView.builder(
      itemCount: reportList.length,
      itemBuilder: (BuildContext context, int index) {
        ReportModel report = reportList[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                width: 60,
                child: Text(report.postOwnerName!, style: Theme.of(context).textTheme.bodyText1, overflow: TextOverflow.ellipsis)
              ),
              Container(
                alignment: Alignment.center,
                width: 80,
                child: Text(report.reportedByName!, style: Theme.of(context).textTheme.bodyText1, overflow: TextOverflow.ellipsis)
              ),
              Container(
                alignment: Alignment.center,
                width: 135,
                child: Text(report.detail, style: Theme.of(context).textTheme.bodyText1)
              ),
              Container(
                alignment: Alignment.center,
                width: 60,
                child: Text(report.status! == 'Discard Report' ? 'Discard' : 'Delete', style: Theme.of(context).textTheme.bodyText1, overflow: TextOverflow.ellipsis)
              ),
            ],
          ),
        );
      }
    );
  }
}