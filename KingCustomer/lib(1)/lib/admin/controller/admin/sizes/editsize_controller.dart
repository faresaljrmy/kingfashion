import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/core/class/statusrequest.dart';
import 'package:kingfashion/core/functions/handingdatacontroller.dart';
import 'package:kingfashion/core/services/services.dart';
import 'package:kingfashion/admin/data/datasource/remote/admin/size_data.dart';
import 'package:kingfashion/data/model/sizemodel.dart';

abstract class EditSizeController extends GetxController {
  editSize();
}

class EditSizeControllerImp extends EditSizeController {
  late TextEditingController name;
  late TextEditingController namear;
  String rgb = "";
  SizeModel sizeModel = SizeModel();
  // File
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  SizesData sizeData = SizesData(Get.find());

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  @override
  void onInit() async {
    sizeModel = Get.arguments["size"];
    name = TextEditingController(text: sizeModel.name);
    namear = TextEditingController(text: sizeModel.namear);
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
  editSize() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      sizeModel.name = name.text;
      sizeModel.namear = namear.text;

      var response = await sizeData.editSize(sizeModel);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        // Start backend
        print("response==$response=================");
        if (response['status'] == "success") {
          Get.rawSnackbar(
              title: "اشعار", messageText: const Text("تم تعديل اللون بنجاح "));
          name.text = "";
          namear.text = "";
          sizeModel = SizeModel();
          // Get.off(page)
        } else {
          statusRequest = StatusRequest.failure;
        }
        // End
      }
    }
    update();
  }
}
