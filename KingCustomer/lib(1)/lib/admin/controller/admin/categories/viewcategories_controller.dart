import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/core/class/statusrequest.dart';
import 'package:kingfashion/core/constant/routes.dart';
import 'package:kingfashion/core/functions/handingdatacontroller.dart';
import 'package:kingfashion/core/functions/translatefatabase.dart';
import 'package:kingfashion/core/services/services.dart';
import 'package:kingfashion/admin/data/datasource/remote/admin/categories_data.dart';
import 'package:kingfashion/data/model/categoriesmodel.dart';
import 'package:kingfashion/data/model/itemsmodel.dart';

abstract class ViewCategoriesController extends GetxController {
  initialData();
  deleteCategorie(String catId, String catImage);
  goToAddCategorie();
  goToEditCategorie(CategoriesModel categoriesModel);
  goToItems(List<CategoriesModel> categories, CategoriesModel selectedCat,
      String categoryid);
  getdata();
}

class ViewCategoriesControllerImp extends ViewCategoriesController {
  List<CategoriesModel> listCateg = [];
  List<ItemsModel> listItems = [];

  CategoriesData categoriesData = CategoriesData(Get.find());

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  @override
  goToAddCategorie() {
    Get.toNamed(AppRoute.categoriesAddpage);
  }

  @override
  goToEditCategorie(categoriesModel) {
    Get.toNamed(AppRoute.categoriesEditpage,
        arguments: {"categorie": categoriesModel});
  }

  @override
  initialData() async {
    statusRequest = StatusRequest.loading;
    await getdata();
    // listCateg = Get.arguments["listcategories"];
    // listItems = Get.arguments["listItems"];

    statusRequest = StatusRequest.success;

    update();
  }

  @override
  getdata() async {
    statusRequest = StatusRequest.loading;
    var response = await categoriesData.getCategories();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        listCateg = [];
        List responsedata = response['data'];
        listCateg.addAll(responsedata.map((e) => CategoriesModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() async {
    await initialData();
    super.onInit();
  }

  @override
  goToItems(categories, selectedCat, categoryid) {
    List<Map<String, dynamic>> listmapcateg = [];
    for (var cat in categories) {
      listmapcateg.add(cat.toJson());
    }
    Get.toNamed(AppRoute.items, arguments: {
      "categories": listmapcateg,
      "selectedcat": int.parse(selectedCat.id ?? "0"),
      "catid": categoryid
    });
  }

  @override
  deleteCategorie(String catId, String catImage) async {
    statusRequest = StatusRequest.loading;
    var response = await categoriesData.deleteCategorie(catId, catImage);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        listCateg.removeWhere((element) => element.id == catId);
        Get.rawSnackbar(
            title: "اشعار", messageText: const Text("تم ازالة التصنيف بنجاح "));
        // data.addAll(response['data']);
      } else if (response['status'] == "failure") {
        Get.rawSnackbar(
            title: translateDatabase("خطأ", "error"),
            messageText: Text(
                translateDatabase(response['error_ar'], response['error'])));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
}
