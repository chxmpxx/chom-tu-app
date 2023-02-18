import 'package:chom_tu/constants/data_constant.dart';

List<String> types(String cat, String subCat) {
  if (cat == 'Top') {
    return topTypes;
  } else if (cat == 'Bottom') {
    if (subCat == 'Shorts') {
      return bottomShortsTypes;
    } else if (subCat == 'Trousers') {
      return bottomTrousersTypes;
    } else if (subCat == 'Skirts') {
      return bottomSkirtsTypes;
    }
  } else if (cat == 'Set') {
    return setTypes;
  } else if (cat == 'Shoes') {
    return shoesTypes;
  } else if (cat == 'Accessory') {
    return accessoryTypes;
  }
  throw Exception('Fail');
}