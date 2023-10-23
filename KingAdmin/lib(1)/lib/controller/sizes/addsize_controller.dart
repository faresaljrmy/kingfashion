import 'package:adminkingfashion/core/funcations/handlinfdatacontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/services/services.dart';
import 'package:adminkingfashion/data/datasource/remote/size_data.dart';
import 'package:adminkingfashion/data/model/sizemodel.dart';

abstract class AddSizeController extends GetxController {
  addSize();
}

class AddSizeControllerImp extends AddSizeController {
  // create some values

  late TextEditingController name;
  late TextEditingController namear;
  bool isAdded = false;
  SizeModel sizeModel = SizeModel();
  // File
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  SizesData sizeData = SizesData(Get.find());

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
  addSize() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      sizeModel.name = name.text;
      sizeModel.namear = namear.text;

      var response = await sizeData.addSize(sizeModel);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        // Start backend
        print("response==$response=================");
        if (response['status'] == "success") {
          Get.rawSnackbar(
              title: "اشعار", messageText: const Text("تم اضافة اللون بنجاح "));
          name.text = "";
          namear.text = "";
          sizeModel = SizeModel();
          isAdded = true;
          // Get.off(page)
        } else {
          statusRequest = StatusRequest.failure;
        }
        // End
      }
    }
    // Get.offNamed(AppRoute.sizeAddpage);
    update();
  }
}
