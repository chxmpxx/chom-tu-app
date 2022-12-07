import 'package:chom_tu/configs/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 22, bottom: 11, left: 22, right: 22),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: kColorsGrey,
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                  ),
                  SizedBox(width: 9),
                  Text('Miso', style: Theme.of(context).textTheme.subtitle2),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset('assets/o6_more_1.svg')
                    )
                  ),
                ],
              ),
              SizedBox(height: 11),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('My outfit for christmas party 💅💅 ', style: Theme.of(context).textTheme.bodyText1)
              ),
            ],
          ),
        ),
        Container(
          color: kColorsGrey,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 22, bottom: 11),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 11),
                child: SvgPicture.asset('assets/o6_like_1.svg'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: Text('  901 Likes', style: Theme.of(context).textTheme.bodyText1),
              )
            ],
          ),
        ),
        Container(
          height: 1,
          child: Expanded(child: Divider(color: kColorsLightGrey))
        ),
      ],
    );
  }
}