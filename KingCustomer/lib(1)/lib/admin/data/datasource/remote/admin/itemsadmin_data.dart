import 'dart:io';

import 'package:kingfashion/core/class/crud.dart';
import 'package:kingfashion/data/model/itemsmodel.dart';
import 'package:kingfashion/linkapi.dart';

class ItemsDataAdmin {
  Crud crud;
  ItemsDataAdmin(this.crud);
  getItems() async {
    var response = await crud.postData(AppLink.itemsViewPage, {});
    return response.fold((l) => l, (r) => r);
  }

  addItem(ItemsModel itmModel, File file) async {
    var response = await crud.postDataWithImage(
        AppLink.itemsAddPage, itmModel.toJson(), file);
    return response.fold((l) => l, (r) => r);
  }

  // Items
  editItem(ItemsModel itmModel, File imageFile) async {
    var response = await crud.postDataWithImage(
        AppLink.itemsEditPage, itmModel.toJson(), imageFile);
    return response.fold((l) => l, (r) => r);
  }

  deleteItem(String itmId, String itmImage) async {
    var response = await crud.postData(
        AppLink.itemsDeletePage, {"id": itmId, "imagename": itmImage});
    return response.fold((l) => l, (r) => r);
  }
}
