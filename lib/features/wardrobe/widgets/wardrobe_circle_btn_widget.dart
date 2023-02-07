import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WardrobeCircleBtnWidget extends StatelessWidget {
  final String value;
  final List<String> list;
  const WardrobeCircleBtnWidget({super.key, required this.value, required this.list});

  @override
  Widget build(BuildContext context) {
    var wardrobeProvider = Provider.of<WardrobeProvider>(context, listen: false);
    
    return Row(
      children: [
        ...List.generate(list.length, (index) {
            return SizedBox(
              width: 87,
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      if(wardrobeProvider.subCategory != list[index]) {
                        wardrobeProvider.setData(list[index], list[index]); 
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: kColorsWhite,
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        border: Border.all(color: wardrobeProvider.subCategory == list[index] ? kColorsBlack : kColorsDarkGrey)
                      ),
                      child: wardrobeProvider.subCategory == list[index] ? Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: kColorsBlack,
                          borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                      ) : Container()
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(list[index], style: wardrobeProvider.subCategory == list[index] ? Theme.of(context).textTheme.headline5 : Theme.of(context).textTheme.headline6)
                ],
              ),
            );
          }
        )
      ],
    );
  }
}