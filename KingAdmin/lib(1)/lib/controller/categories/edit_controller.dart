import 'dart:io';

import 'package:adminkingfashion/controller/categories/view_controller.dart';
import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/core/funcations/handlinfdatacontroller.dart';
import 'package:adminkingfashion/core/funcations/uploadfiles.dart';
import 'package:adminkingfashion/data/datasource/remote/categories_data.dart';
import 'package:adminkingfashion/data/model/categoriesmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CategoresEditController extends GetxController {
  CategoriesDataRemote categoriesDataRemote = CategoriesDataRemote(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  GlobalKey<FormState> formstateeditcate = GlobalKey<FormState>();
// List<CategoriesModel> data =[];
  late TextEditingController name;
  late TextEditingController namear;

  CategoriesModel? categoriesModel;
  File? file;

  choosUploadFile() async {
    file = await fileUpload(true);
    update();
  }

  editdata() async {
    if (formstateeditcate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      Map data = {
        "name": name.text,
        "namear": namear.text,
        "id": categoriesModel!.id.toString(),
        "imageold": categoriesModel!.image
      };
      var response = await categoriesDataRemote.editData(data, file);
      print("================================= Controller $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.snackbar("نجاح", "تم تعديل القسم");
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
    categoriesModel = Get.arguments["categoriesModel"];
    name = TextEditingController();
    namear = TextEditingController();
    name.text = categoriesModel!.name!;
    namear.text = categoriesModel!.nameAr!;
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    namear.dispose();
    super.dispose();
  }
}
