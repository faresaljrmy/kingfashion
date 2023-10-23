import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/core/class/statusrequest.dart';
import 'package:kingfashion/core/constant/routes.dart';
import 'package:kingfashion/core/functions/handingdatacontroller.dart';
import 'package:kingfashion/core/functions/translatefatabase.dart';
import 'package:kingfashion/core/services/services.dart';
import 'package:kingfashion/admin/data/datasource/remote/admin/size_data.dart';
import 'package:kingfashion/data/model/sizemodel.dart';

abstract class ViewSizesController extends GetxController {
  initialData();
  deleteSize(String sizId);
  goToAddSize();
  goToEditSize(SizeModel sizesModel);
  getdata();
}

class ViewSizesControllerImp extends ViewSizesController {
  List<SizeModel> listsiz = [];

  SizesData sizesData = SizesData(Get.find());

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  @override
  goToAddSize() {
    Get.toNamed(AppRoute.sizesAddpage);
  }

  @override
  goToEditSize(sizesModel) {
    Get.toNamed(AppRoute.sizesEditpage, arguments: {"size": sizesModel});
  }

  @override
  initialData() async {
    statusRequest = StatusRequest.loading;
    await getdata();
    //listsiz = Get.arguments["listSizes"];
    statusRequest = StatusRequest.success;

    update();
  }

  @override
  getdata() async {
    statusRequest = StatusRequest.loading;
    var response = await sizesData.getSizes();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        listsiz = [];
        List responsedata = response['data'];
        listsiz.addAll(responsedata.map((e) => SizeModel.fromJson(e)));
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
  deleteSize(String sizId) async {
    statusRequest = StatusRequest.loading;
    var response = await sizesData.deleteSize(sizId);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        listsiz.removeWhere((element) => element.id == sizId);
        Get.rawSnackbar(
            title: "اشعار", messageText: const Text("تم ازالة اللون بنجاح "));
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
