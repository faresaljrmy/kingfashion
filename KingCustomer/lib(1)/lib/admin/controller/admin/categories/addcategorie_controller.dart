import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/core/class/statusrequest.dart';
import 'package:kingfashion/core/functions/handingdatacontroller.dart';
import 'package:kingfashion/core/functions/selectimagepicker.dart';
import 'package:kingfashion/core/services/services.dart';
import 'package:kingfashion/admin/data/datasource/remote/admin/categories_data.dart';
import 'package:kingfashion/data/model/categoriesmodel.dart';

abstract class ViewCategorieController extends GetxController {
  addCategorie();
}

class AddCategorieControllerImp extends ViewCategorieController {
  late TextEditingController name;
  late TextEditingController namear;
  File? imageFile;
  bool selectedImage = false;
  bool isAdded = false;
  CategoriesModel categoriesModel = CategoriesModel();
  // File
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  CategoriesData categoriesData = CategoriesData(Get.find());

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  @override
  void onInit() async {
    name = TextEditingController();
    namear = TextEditingController();
    statusRequest = StatusRequest.none;
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    namear.dispose();
    super.dispose();
  }

  @override
  addCategorie() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      categoriesModel.name = name.text;
      categoriesModel.nameAr = namear.text;
      // categoriesModel.newImage = imageFile;

      var response =
          await categoriesData.addCategorie(categoriesModel, imageFile!);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        // Start backend
        if (response['status'] == "success") {
          Get.rawSnackbar(
              title: "اشعار",
              messageText: const Text("تم اضافة التصنيف بنجاح "));
          name.text = "";
          namear.text = "";
          imageFile = null;
          selectedImage = false;
          categoriesModel = CategoriesModel();
          isAdded = true;
          // Get.off(page)
        } else {
          statusRequest = StatusRequest.failure;
        }
        // End
      }
    }
    update();
  }

  selectImageFromGallery() async {
    imageFile = await pickImageFromGallery();
    if (imageFile != null) {
      selectedImage = true;
    }
    update();
  }

  selectImageFromCamera() async {
    imageFile = await pickImageFromCamera();
    if (imageFile != null) {
      selectedImage = true;
    }
    update();
  }
}
