import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/core/class/statusrequest.dart';
import 'package:kingfashion/core/functions/handingdatacontroller.dart';
import 'package:kingfashion/core/services/services.dart';
import 'package:kingfashion/admin/data/datasource/remote/admin/color_data.dart';
import 'package:kingfashion/data/model/colormodel.dart';

abstract class ViewColorController extends GetxController {
  addColor();
}

class AddColorControllerImp extends ViewColorController {
  // create some values
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  late TextEditingController name;
  late TextEditingController namear;
  String rgb = "";
  bool isAdded = false;
  ColorModel colorsModel = ColorModel();
  // File
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  ColorsData colorsData = ColorsData(Get.find());

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  @override
  void onInit() async {
    name = TextEditingController();
    namear = TextEditingController();
    statusRequest = StatusRequest.success;
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    namear.dispose();
    super.dispose();
  }

  @override
  addColor() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      colorsModel.name = name.text;
      colorsModel.nameAr = namear.text;

      var response = await colorsData.addColor(colorsModel);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        // Start backend
        if (response['status'] == "success") {
          Get.rawSnackbar(
              title: "اشعار", messageText: const Text("تم اضافة اللون بنجاح "));
          name.text = "";
          namear.text = "";
          colorsModel = ColorModel();
          isAdded = true;
          // Get.off(page)
        } else {
          statusRequest = StatusRequest.failure;
        }
        // End
      }
    }
    // Get.offNamed(AppRoute.colorsAddpage);
    update();
  }

  changeColor() {
    currentColor = pickerColor;
    colorsModel.rgb = pickerColor.value.toRadixString(16);
    update();
  }
}
