import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/core/class/statusrequest.dart';
import 'package:kingfashion/core/constant/routes.dart';
import 'package:kingfashion/core/functions/handingdatacontroller.dart';
import 'package:kingfashion/core/functions/translatefatabase.dart';
import 'package:kingfashion/core/services/services.dart';
import 'package:kingfashion/admin/data/datasource/remote/admin/color_data.dart';
import 'package:kingfashion/data/model/colormodel.dart';

abstract class ViewColorsController extends GetxController {
  initialData();
  deleteColor(String clrId);
  goToAddColor();
  goToEditColor(ColorModel colorsModel);
  getdata();
}

class ViewColorsControllerImp extends ViewColorsController {
  List<ColorModel> listclr = [];

  ColorsData colorsData = ColorsData(Get.find());

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  @override
  goToAddColor() {
    Get.toNamed(AppRoute.colorsAddpage);
  }

  @override
  goToEditColor(colorsModel) {
    Get.toNamed(AppRoute.colorsEditpage, arguments: {"color": colorsModel});
  }

  @override
  initialData() async {
    statusRequest = StatusRequest.loading;
    await getdata();
    //listclr = Get.arguments["listColors"];
    statusRequest = StatusRequest.success;

    update();
  }

  @override
  getdata() async {
    statusRequest = StatusRequest.loading;
    var response = await colorsData.getColors();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        listclr = [];
        List responsedata = response['data'];
        listclr.addAll(responsedata.map((e) => ColorModel.fromJson(e)));
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
  deleteColor(String clrId) async {
    statusRequest = StatusRequest.loading;
    var response = await colorsData.deleteColor(clrId);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        listclr.removeWhere((element) => element.id == clrId);
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
