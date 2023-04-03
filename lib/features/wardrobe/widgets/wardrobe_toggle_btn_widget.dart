import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget WardrobeToggleBtnWidget (context) {
  var wardrobeProvider = Provider.of<WardrobeProvider>(context, listen: false);

  return Padding(
    padding: const EdgeInsets.all(22),
    child: GestureDetector(
      onTap: () {
        wardrobeProvider.setIsDetect();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: wardrobeProvider.isDetect ? Alignment.centerRight : Alignment.centerLeft,
            width: 35,
            height: 16,
            decoration: BoxDecoration(
              color: wardrobeProvider.isDetect ? kColorsBlack : kColorsDarkGrey,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: kColorsWhite,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          Text('AI', style: Theme.of(context).textTheme.headline5)
        ],
      ),
    ),
  );
}