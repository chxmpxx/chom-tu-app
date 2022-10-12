import 'package:flutter/material.dart';

class TypeBarWidget extends StatelessWidget {
  const TypeBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    List type = ['All', 'Shirt', 'Turtleneck', 'Jacket', 'Waistcoat', 'Sweater', 'Strapless'];

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 30,
      child: ListView.separated(
        // shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){},
            child: Text(type[index], style: Theme.of(context).textTheme.bodyText1),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 15);
        },
        itemCount: type.length
      ),
    );
  }
}