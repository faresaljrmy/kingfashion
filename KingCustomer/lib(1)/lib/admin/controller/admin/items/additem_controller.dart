import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/core/class/statusrequest.dart';
import 'package:kingfashion/core/functions/handingdatacontroller.dart';
import 'package:kingfashion/core/functions/selectimagepicker.dart';
import 'package:kingfashion/core/services/services.dart';
import 'package:kingfashion/admin/data/datasource/remote/admin/itemsadmin_data.dart';
import 'package:kingfashion/data/model/itemsmodel.dart';

abstract class AddItemsController extends GetxController {
  addItem();
}

class AddItemControllerImp extends AddItemsController {
  late TextEditingController name;
  late TextEditingController namear;
  File? imageFile;
  bool selectedImage = false;
  bool isAdded = false;
  ItemsModel itemsModel = ItemsModel();
  // File
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  ItemsDataAdmin itemsData = ItemsDataAdmin(Get.find());

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
  addItem() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      itemsModel.name = name.text;
      itemsModel.nameAr = namear.text;
      // itemsModel.newImage = imageFile;

      var response = await itemsData.addItem(itemsModel, imageFile!);
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
          itemsModel = ItemsModel();
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
