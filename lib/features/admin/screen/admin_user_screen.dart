import 'package:chom_tu/common_widgets/filter_bar_widget.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/admin/providers/admin_provider.dart';
import 'package:chom_tu/features/admin/providers/admin_tab_status_provider.dart';
import 'package:chom_tu/features/admin/providers/admin_user_filter_tab_provider.dart';
import 'package:chom_tu/features/admin/widgets/admin_drawer_widget.dart';
import 'package:chom_tu/features/admin/widgets/user_charges_filter_tab_widget.dart';
import 'package:chom_tu/features/admin/widgets/user_sort_filter_tab_widget.dart';
import 'package:chom_tu/features/admin/widgets/user_status_filter_tab_widget.dart';
import 'package:chom_tu/features/auth/models/user_model.dart';
import 'package:chom_tu/features/auth/providers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AdminUserScreen extends StatelessWidget {
  const AdminUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var adminProvider = Provider.of<AdminProvider>(context, listen: false);
    var filterTab = Provider.of<AdminUserFilterTabProvider>(context, listen: true);
    var tabStatus = Provider.of<AdminTabStatusProvider>(context, listen: false);

    if (tabStatus.status) {
      tabStatus.tab(tabStatus.indexTab);
    }
    
    List<Widget> filterTabContent = [
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
                      width: 61,
                      child: Text('Username', style: Theme.of(context).textTheme.subtitle2)
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
                  child: FutureBuilder(
                    future: UserController().getAllUser(filterTab.charges, filterTab.status),
                    builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
                      if(snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      else if(snapshot.connectionState == ConnectionState.done) {
                        List<UserModel> userList = snapshot.data!;
                        return userBody(userList, adminProvider);
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
                        height: tabStatus.indexTab == 0 ? MediaQuery.of(context).size.width * 0.29 : MediaQuery.of(context).size.width * 0.44,
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
                  child: tabStatus.indexTab == 0 && tabStatus.status == true ? const FilterBarWidget(title: 'Charges', status: true) : const FilterBarWidget(title: 'Charges', status: false)
                ),
                InkWell(
                  onTap: () {
                    tabStatus.tab(1);
                  },
                  child: tabStatus.indexTab == 1 && tabStatus.status == true ? const FilterBarWidget(title: 'Status', status: true) : const FilterBarWidget(title: 'Status', status: false)
                )
              ],
            );
          }
        )
      ),
    );
  }

  Widget userBody(List<UserModel> userList, AdminProvider adminProvider) {
    return ListView.builder(
      itemCount: userList.length,
      itemBuilder: (BuildContext context, int index) {
        UserModel user = userList[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 11),
          child: Consumer<AdminProvider>(
          builder: (_, value, __) {
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 61,
                    child: Text(user.name, style: Theme.of(context).textTheme.bodyText1, overflow: TextOverflow.ellipsis)
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 60,
                    child: user.isBan! ? Text('Ban', style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kColorsRed))
                      : Text('Active', style: Theme.of(context).textTheme.bodyText1)
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 60,
                    child: Text(user.totalCharges.toString(), style: Theme.of(context).textTheme.bodyText1)
                  ),
                  InkWell(
                    onTap: () async {
                      Map<String, String> data = { 'is_ban': (user.isBan! ? 0:1).toString() };
                      await UserController().updateUserStatus(user.id, data);
                      userList[index] = await UserController().getUser(user.id!);
                      user = userList[index];
                      adminProvider.update();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 24,
                      width: 60,
                      decoration: BoxDecoration(
                        color: user.isBan! ? kColorsLightGrey : kColorsBlack,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        user.isBan! ? 'Unban':'Ban',
                        style: user.isBan! ? Theme.of(context).textTheme.subtitle2
                          : Theme.of(context).textTheme.subtitle2!.copyWith(color: kColorsWhite)
                      ),
                    ),
                  ),
                ],
              );
            }
          )
        );
      }
    );
  }
}