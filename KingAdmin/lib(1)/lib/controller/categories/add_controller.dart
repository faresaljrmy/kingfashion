import 'dart:io';

import 'package:adminkingfashion/controller/categories/view_controller.dart';
import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/core/funcations/handlinfdatacontroller.dart';
import 'package:adminkingfashion/core/funcations/uploadfiles.dart';
import 'package:adminkingfashion/core/services/services.dart';
import 'package:adminkingfashion/data/datasource/remote/categories_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CategoresAddController extends GetxController {
  CategoriesDataRemote categoriesDataRemote = CategoriesDataRemote(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  GlobalKey<FormState> formstateaddcate = GlobalKey<FormState>();
// List<CategoriesModel> data =[];
  late TextEditingController name;
  late TextEditingController namear;
  MyServices myServices = Get.find();
  File? file;

  choosUploadFile() async {
    file = await fileUpload(true);
    update();
  }

  adddata() async {
    if (formstateaddcate.currentState!.validate()) {
      // if (file == null) {
      //   return Get.snackbar("تنبية", "الرجاء اختيار ايقونةالقسم");
      // }
      statusRequest = StatusRequest.loading;
      update();
      Map data = {
        "name": name.text,
        "namear": namear.text,
        "userid": myServices.sharedPreferences.getString("id")
      };
      var response;
      if (file == null) {
        response = await categoriesDataRemote.addData(data);
      } else {
        response = await categoriesDataRemote.addDataWithImage(data, file!);
      }
      // print("================================= Controller $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.snackbar("نجاح", "تم إضافة القسم");
          Get.offNamed(AppRoute.categoriesview);
          CategoresViewController cv = Get.find();
          cv.getdata();
        } else {
          statusRequest = StatusRequest.failure;
        }
      }

      update();
    }
  }

  @override
  void onInit() {
    name = TextEditingController();
    namear = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    namear.dispose();
    super.dispose();
  }
}
