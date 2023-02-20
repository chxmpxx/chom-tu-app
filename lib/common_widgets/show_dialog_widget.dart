import 'package:chom_tu/constants/themes/colors.dart';
import 'package:flutter/material.dart';

void showDialogWidget(context, title, msg, continueBtn, function) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: Theme.of(context).textTheme.subtitle1),
        content: Text(msg, style: Theme.of(context).textTheme.headline5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel', style: Theme.of(context).textTheme.headline2)
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: function,
              child: Container(
                width: 91,
                height: 34,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: kColorsBlack,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Text(continueBtn, style: Theme.of(context).textTheme.headline4)
              ),
            ),
          )
        ],
      );
    }
  );
}