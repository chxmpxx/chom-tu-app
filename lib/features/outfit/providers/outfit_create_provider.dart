import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/outfit/providers/delete_item_provider.dart';
import 'package:chom_tu/features/outfit/providers/is_delete_btn_active_provider.dart';
import 'package:chom_tu/features/outfit/providers/show_delete_btn_provider.dart';
import 'package:chom_tu/features/outfit/widgets/overlayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OutfitCreateProvider with ChangeNotifier {

  bool tabStatus = false;
  int outfitIndex = 0;
  int bottomIndex = 0;

  Color backgroundColor = kColorsGrey;
  String? top, bottom, set, shoes, accessory;
  Widget? topW;
  bool showDeleteBtn = false;
  bool isDeleteBtnActive = false;
  List<Widget> items = [];

  selectTab() {
    tabStatus == true ? tabStatus = false : tabStatus = true;
    notifyListeners();
  }

  setIndex(data) {
    outfitIndex = data;
    notifyListeners();
  }

  setBottomIndex(data) {
    bottomIndex = data;
    notifyListeners();
  }

  selectBackgroundColor(color) {
    backgroundColor = color;
    notifyListeners();
  }

  selectTop(top, context, key) {
    var providerShowDeleteBtn = Provider.of<ShowDeleteBtnProvider>(context, listen: false);
    var providerIsDeleteBtnActive = Provider.of<IsDeleteBtnActiveProvider>(context, listen: false);
    var providerDeleteItem = Provider.of<DeleteItemProvider>(context, listen: false);

    this.top = top;
    topW = SizedBox(
      width: 150,
      height: 150,
      child: Image.asset(top, fit: BoxFit.cover,),
    );

    items.add(OverlayedWidget(
      key: Key(key.toString()),
      child: topW!,
      onDragStart: (){
        if(!showDeleteBtn) {
          showDeleteBtn = true;
          providerShowDeleteBtn.setShowDeleteBtn(true);
        }  
      },
      onDragEnd: (offset, key){
        if(showDeleteBtn) {
          showDeleteBtn = false;
          providerShowDeleteBtn.setShowDeleteBtn(false);
        }

        if(offset.dy > MediaQuery.of(context).size.width - 33 && 
          offset.dx > (MediaQuery.of(context).size.width/2) - 18 && offset.dx < (MediaQuery.of(context).size.width/2) + 18) {
          items.removeWhere((widget) => widget.key == key);
          providerDeleteItem.setDeleteItem();
        }
      },
      onDragUpdate: (offset, key){
        // List<Map<String, String>> outfitDetail = [{'key': key.toString(), 'cat': 'Top', 'color': 'Pink', 'position': offset.toString()}];
        // print(outfitDetail);

        if(offset.dy > MediaQuery.of(context).size.width - 33 && 
          offset.dx > (MediaQuery.of(context).size.width/2) - 18 && offset.dx < (MediaQuery.of(context).size.width/2) + 18) {
          if(!isDeleteBtnActive) {
            isDeleteBtnActive = true;
            providerIsDeleteBtnActive.setIsDeleteBtnActive(true);
          }
        }
        else {
          if(isDeleteBtnActive) {
            isDeleteBtnActive = false;
            providerIsDeleteBtnActive.setIsDeleteBtnActive(false);
          }
        }
      },
    ));
    notifyListeners();
  }
  
  // SelectBottom(bottom) {
  //   this.bottom = bottom;
  //   notifyListeners();
  // }

  // SelectSet(set) {
  //   this.set = set;
  //   notifyListeners();
  // }

  // Selectshoes(shoes) {
  //   this.shoes = shoes;
  //   notifyListeners();
  // }

  // SelectAccessory(accessory) {
  //   this.accessory = accessory;
  //   notifyListeners();
  // }

}