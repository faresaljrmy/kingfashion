// ignore_for_file: overridden_fields

import 'package:kingfashion/controller/home_controller.dart';
import 'package:kingfashion/core/class/statusrequest.dart';
import 'package:kingfashion/core/constant/routes.dart';
import 'package:kingfashion/core/functions/handingdatacontroller.dart';
import 'package:kingfashion/core/services/services.dart';
import 'package:kingfashion/data/datasource/remote/favorite_data.dart';
import 'package:kingfashion/data/datasource/remote/items_data.dart';
import 'package:kingfashion/data/model/itemsmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ItemsController extends GetxController {
  intialData();
  changeCat(int val, String catval);
  getItems(String categoryid);
  goToPageProductDetails(ItemsModel itemsModel);
}

class ItemsControllerImp extends SearchMixController {
  List categories = [];
  String? catid;
  int? selectedCat;

  ItemsData testData = ItemsData(Get.find());
  FavoriteData favoriteData = FavoriteData(Get.find());

  List<ItemsModel> listItems = [];

  @override
  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  @override
  void onInit() {
    search = TextEditingController();
    intialData();
    super.onInit();
  }

  // getAllImages(String itemid) async {
  //   statusRequest = StatusRequest.loading;
  //   var response = await testData.getImagesItem(itemid);
  //   statusRequest = handlingData(response);
  //   if (StatusRequest.success == statusRequest) {
  //     // Start backend
  //     if (response['status'] == "success") {
  //       List responsedata = response['data'];
  //       List<String> listimg = [];
  //       // itemsModel.listImage = [];
  //       for (var value in responsedata) {
  //         listimg.add(value["itm_image"]);
  //       }
  //       return listimg;
  //       // data.addAll(response['data']);
  //     } else {
  //       statusRequest = StatusRequest.failure;
  //     }
  //     // End
  //   }
  // }

  intialData() {
    categories = Get.arguments['categories'];
    selectedCat = Get.arguments['selectedcat'];
    catid = Get.arguments['catid'];
    getItems(catid!);
  }

  changeCat(val, catval) {
    selectedCat = val;
    catid = catval;
    getItems(catid!);

    update();
  }

  getItems(categoryid) async {
    statusRequest = StatusRequest.loading;
    var response = await testData.getData(
        categoryid, myServices.sharedPreferences.getString("id")!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        List list = response['data'];
        listItems = [];
        listItems.addAll(list.map((e) => ItemsModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }

  goToPageProductDetails(ItemsModel itemsModel) async {
    if (itemsModel.listImage == null && itemsModel.listImage!.isEmpty) {
      itemsModel.listImage = [];
      itemsModel.listImage!.add(itemsModel.itemsImage!);
    } else {
      itemsModel.listImage!.add(itemsModel.itemsImage!);
    }
    // await getAllImages(itemsModel.id!);
    Get.toNamed(AppRoute.productdetails, arguments: {"itemsmodel": itemsModel});
  }

  addFavorite(String itemsid, int index) async {
    // data.clear();
    // statusRequest = StatusRequest.loading;
    var response = await favoriteData.addFavorite(
        myServices.sharedPreferences.getString("id")!, itemsid);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        listItems[index].favorite = "1";
        update();
      }
      // End
    }
  }

  removeFavorite(String itemsid, int index) async {
    // statusRequest = StatusRequest.loading;
    var response = await favoriteData.removeFavorite(
        myServices.sharedPreferences.getString("id")!, itemsid);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        listItems[index].favorite = "0";
        update();
      } // End
    }
  }
}


























// class FavoriteController extends GetxController {
//   Map isFavorite = {};

//   setFavorite(id, val) {
//     isFavorite[id] = val;
//     print(isFavorite[id]);
//     update();
//   }
// }
