import 'dart:io';

import 'package:kingfashion/core/class/crud.dart';
import 'package:kingfashion/data/model/categoriesmodel.dart';
import 'package:kingfashion/linkapi.dart';

class CategoriesData {
  Crud crud;
  CategoriesData(this.crud);
  getCategories() async {
    var response = await crud.postData(AppLink.categoriesViewPage, {});
    return response.fold((l) => l, (r) => r);
  }

  addCategorie(CategoriesModel catModel, File file) async {
    var response = await crud.postDataWithImage(
        AppLink.categoriesAddPage, catModel.toJsonAdd(), file);
    return response.fold((l) => l, (r) => r);
  }

  // Categories
  editCategorie(CategoriesModel catModel, File imageFile) async {
    var response = await crud.postDataWithImage(
        AppLink.categoriesEditPage, catModel.toJsonEdit(), imageFile);
    return response.fold((l) => l, (r) => r);
  }

  deleteCategorie(String catId, String catImage) async {
    var response = await crud.postData(
        AppLink.categoriesDeletePage, {"id": catId, "imagename": catImage});
    return response.fold((l) => l, (r) => r);
  }
}
