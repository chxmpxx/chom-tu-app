import 'package:chom_tu/constants/data_constant.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/admin/providers/admin_report_filter_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

Widget reportDetailFilterTab(context) {
  var filterTab = Provider.of<AdminReportFilterTabProvider>(context, listen: false);

  return Stack(
    children: [
      Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          children: [
            Consumer<AdminReportFilterTabProvider>(
              builder: (_, value, __) {
                return filterBtn(filterTab, reportDetail, context);
              }
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),

      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Container(
            alignment: Alignment.bottomRight,
            width: MediaQuery.of(context).size.width,
            height: 40,
            color: kColorsWhite,
            child: InkWell(
              onTap: (){
                filterTab.removeAllDetails();
              },
              child: SvgPicture.asset('assets/icons/o9_bin_1.svg')
            ),
          ),
        ),
      ),
    ],
  );
}

Widget filterBtn(AdminReportFilterTabProvider filterTab, List<String> list, context) {
  return Wrap(
    runSpacing: 18,
    spacing: 18,
    children: [
      ...List.generate(list.length, (index) {
        return InkWell(
          onTap: (){
            if(filterTab.details.contains(list[index])) {
              filterTab.removeDetails(list[index]);
            } else {
              filterTab.addDetails(list[index]);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: filterTab.details.contains(list[index]) ? Border.all(color: kColorsBlack) : Border.all(color: kColorsLightGrey)
            ),
            child: Text(list[index], style: filterTab.details.contains(list[index]) ? Theme.of(context).textTheme.bodyText1 : Theme.of(context).textTheme.caption)
          ),
        );
      }),
    ],
  );
}