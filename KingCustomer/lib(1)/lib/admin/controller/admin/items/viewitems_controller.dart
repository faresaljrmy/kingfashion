import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/core/class/statusrequest.dart';
import 'package:kingfashion/core/constant/routes.dart';
import 'package:kingfashion/core/functions/handingdatacontroller.dart';
import 'package:kingfashion/core/functions/translatefatabase.dart';
import 'package:kingfashion/core/services/services.dart';
import 'package:kingfashion/admin/data/datasource/remote/admin/itemsadmin_data.dart';
import 'package:kingfashion/data/model/itemsmodel.dart';

abstract class ViewItemsController extends GetxController {
  initialData();
  deleteItem(String catId, String catImage);
  goToAddItem();
  goToEditItem(ItemsModel itemsModel);
  // goToItems(List<ItemsModel> items, ItemsModel selectedCat,
  //     String categoryid);
  getdata();
}

class ViewItemsControllerImp extends ViewItemsController {
  List<ItemsModel> listItem = [];
  List<ItemsModel> listItems = [];

  ItemsDataAdmin itemsData = ItemsDataAdmin(Get.find());

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  @override
  goToAddItem() {
    Get.toNamed(AppRoute.itemsAddpage);
  }

  @override
  goToEditItem(itemsModel) {
    Get.toNamed(AppRoute.itemsEditpage, arguments: {"item": itemsModel});
  }

  @override
  initialData() async {
    statusRequest = StatusRequest.loading;
    await getdata();
    // listItem = Get.arguments["listitems"];

    statusRequest = StatusRequest.success;

    update();
  }

  @override
  getdata() async {
    statusRequest = StatusRequest.loading;
    var response = await itemsData.getItems();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        listItem = [];
        List responsedata = response['data'];
        listItem.addAll(responsedata.map((e) => ItemsModel.fromJson(e)));
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
  deleteItem(String catId, String catImage) async {
    statusRequest = StatusRequest.loading;
    var response = await itemsData.deleteItem(catId, catImage);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        listItem.removeWhere((element) => element.id == catId);
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
