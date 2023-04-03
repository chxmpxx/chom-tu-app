import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/outfit/providers/delete_item_provider.dart';
import 'package:chom_tu/features/outfit/providers/is_delete_btn_active_provider.dart';
import 'package:chom_tu/features/outfit/providers/show_delete_btn_provider.dart';
import 'package:chom_tu/features/outfit/widgets/overlayed_widget.dart';
import 'package:chom_tu/features/wardrobe/models/wardrobe_model.dart';
import 'package:chom_tu/utils/get_value_from_key_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OutfitCreateProvider with ChangeNotifier {

  String? imagePath;
  String? image;
  String? style;
  String? detail;

  bool tabStatus = false;
  int outfitIndex = 0;
  int bottomIndex = 0;

  Color backgroundColor = bgColorsBeige;
  Color notConfirmBackgroundColor = bgColorsBeige;
  bool showDeleteBtn = false;
  bool isDeleteBtnActive = false;

  Widget? item;
  List<Widget> items = [];

  List<String> notConfirmList = [];
  // collect Strings for filters wardrobe
  List<String> confirmList = [];

  Map<String, double> offsets = {'dx': 0, 'dy': 0};
  Map<Key, Map<String, double>> itemsOffsets = {};

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

  removeAllWardrobe() {
    items = [];
    notConfirmList = [];
    confirmList = [];
    offsets = {'dx': 0, 'dy': 0};
    itemsOffsets = {};
    notifyListeners();
  }

  selectWardrobe(WardrobeModel wardrobe, context) async {
    var providerShowDeleteBtn = Provider.of<ShowDeleteBtnProvider>(context, listen: false);
    var providerIsDeleteBtnActive = Provider.of<IsDeleteBtnActiveProvider>(context, listen: false);
    var providerDeleteItem = Provider.of<DeleteItemProvider>(context, listen: false);

    notConfirmList.add(wardrobe.id.toString());
    confirmList.add(wardrobe.id.toString());
    itemsOffsets[Key(wardrobe.id.toString())] = offsets;

    item = Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(wardrobe.wardrobeImg!),
          fit: BoxFit.cover,
        ),
      ),
    );

    items.add(OverlayedWidget(
      key: Key(wardrobe.id.toString()),
      child: item!,
      onDragStart: (){
        if(!showDeleteBtn) {
          showDeleteBtn = true;
          providerShowDeleteBtn.setShowDeleteBtn(true);
        }  
      },
      onDragEnd: (offset, key, context){
        offsets["dx"] = offset.dx;
        offsets["dy"] = offset.dy;
        itemsOffsets[key!] = offsets;

        if(showDeleteBtn) {
          showDeleteBtn = false;
          providerShowDeleteBtn.setShowDeleteBtn(false);
        }

        // Delete Item
        if(offset.dy > MediaQuery.of(context).size.width - 33 && 
          offset.dx > (MediaQuery.of(context).size.width/2) - 18 && offset.dx < (MediaQuery.of(context).size.width/2) + 18) {
          confirmList.remove(getValueFromKeyType(key));
          items.removeWhere((widget) => widget.key == key);

          if(notConfirmList.contains(getValueFromKeyType(key))) {
            notConfirmList.remove(getValueFromKeyType(key));
          }
          providerDeleteItem.setDeleteItem();
          notifyListeners();
        }
      },
      onDragUpdate: (offset, key, context){
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

  confirmWardrobe() {
    notConfirmList = [];
  }

  notConfirmWardrobe(context) {
    var providerDeleteItem = Provider.of<DeleteItemProvider>(context, listen: false);

    for (var key in notConfirmList) {
      confirmList.remove(key);
      items.removeWhere((widget) => widget.key == Key(key));
    }
    
    providerDeleteItem.setDeleteItem();
  }

  confirmBackground() {
    notConfirmBackgroundColor = backgroundColor;
    notifyListeners();
  }

  notConfirmBackground() {
    backgroundColor = notConfirmBackgroundColor;
    notifyListeners();
  }
}