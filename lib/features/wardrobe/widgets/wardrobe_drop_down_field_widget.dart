import 'package:chom_tu/constants/data_constant.dart';
import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_provider.dart';
import 'package:chom_tu/utils/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WardrobeDropDownField extends StatelessWidget {
  final List<String> list;
  final String name;
  final String wardrobeValue;
  const WardrobeDropDownField({super.key, required this.list, required this.name, required this.wardrobeValue});

  @override
  Widget build(BuildContext context) {
    var wardrobeProvider = Provider.of<WardrobeProvider>(context, listen: false);
    String dropdownValue = wardrobeValue;

    if(!list.contains(wardrobeValue)) {
      dropdownValue = types(wardrobeProvider.category, wardrobeProvider.subCategory)[0];
      wardrobeProvider.type = types(wardrobeProvider.category, wardrobeProvider.subCategory)[0];
    }

    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            SizedBox(
              width: 93,
              child: Text(name, style: Theme.of(context).textTheme.headline2),
            ),
            Expanded(
              child: Consumer<WardrobeProvider>(
                builder: (_, value, __) {
                  return DropdownButton<String>(
                    dropdownColor: kColorsWhite,
                    value: dropdownValue,
                    icon: SvgPicture.asset('assets/icons/o4_down_1.svg', color: kColorsBlack),
                    elevation: 3,
                    style: Theme.of(context).textTheme.headline5,
                    isExpanded: true,
                    underline: Container(
                      height: kAppbarBorderWidth,
                      color: kColorsLightGrey,
                    ),
                    onChanged: (String? value) {
                      wardrobeProvider.setData(name, value!);
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: name == 'Color' ? 
                          Row(
                            children: [
                              value != 'Multi' ? Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: colorCodes[list.indexOf(value)],
                                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                                  border: Border.all(color: kColorsLightGrey)
                                ),
                              ) : SvgPicture.asset('assets/icons/o9_multi_1.svg'),
                              const SizedBox(width: 7),
                              Text(value, style:Theme.of(context).textTheme.headline5),
                            ],
                          )
                          : Text(value, style:Theme.of(context).textTheme.headline5)
                      );
                    }).toList(),
                  );
                }
              ),
            ),
          ],
        ),
      ],
    );
  }
}