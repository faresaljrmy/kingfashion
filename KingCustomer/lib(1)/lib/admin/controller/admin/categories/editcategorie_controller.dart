import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/core/class/statusrequest.dart';
import 'package:kingfashion/core/constant/color.dart';
import 'package:kingfashion/core/functions/handingdatacontroller.dart';
import 'package:kingfashion/core/functions/selectimagepicker.dart';
import 'package:kingfashion/core/services/services.dart';
import 'package:kingfashion/admin/data/datasource/remote/admin/categories_data.dart';
import 'package:kingfashion/data/model/categoriesmodel.dart';

abstract class EditCategorieController extends GetxController {
  editCategorie();
}

class EditCategorieControllerImp extends EditCategorieController {
  late TextEditingController name;
  late TextEditingController namear;
  File? imageFile;
  bool isChangeImage = false;
  bool isChangeData = false;
  bool isNeddEdit = false;

  CategoriesModel categoriesModel = CategoriesModel();
  // File
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  CategoriesData categoriesData = CategoriesData(Get.find());

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  @override
  void onInit() async {
    statusRequest = StatusRequest.loading;
    categoriesModel = Get.arguments["categorie"];
    if (categoriesModel.id != null && categoriesModel.id!.isNotEmpty) {
      name = TextEditingController(text: categoriesModel.name);
      namear = TextEditingController(text: categoriesModel.nameAr);
      // imageFile = File.fromUri(Uri.dataFromString(
      //     "${AppLink.imagestCategories}/${categoriesModel.image}"));

      if (imageFile != null || categoriesModel.image != null) {
        isChangeImage = true;
      }
      statusRequest = StatusRequest.success;
    }
    name.addListener(() {
      isChangeData = true;
      update();
    });
    namear.addListener(() {
      isChangeData = true;
      update();
    });
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
  editCategorie() async {
    if (isChangeData) {
      await Get.defaultDialog(
          title: "تاكيد",
          titleStyle: const TextStyle(
              color: AppColor.primaryColor, fontWeight: FontWeight.bold),
          middleText:
              " هل تريد بالتاكيد تعديل التصنيف للتاكيد اضغط نعم للالغاء اضغط لا",
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColor.primaryColor)),
                onPressed: () {
                  isNeddEdit = true;
                  Get.back();
                },
                child: const Text("نعم")),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColor.primaryColor)),
                onPressed: () {
                  isNeddEdit = false;
                  Get.back();
                },
                child: const Text("لا"))
          ]);

      if (isNeddEdit) {
        if (formstate.currentState!.validate()) {
          statusRequest = StatusRequest.loading;
          categoriesModel.name = name.text;
          categoriesModel.nameAr = namear.text;
          // categoriesModel.newImage = imageFile;

          var response =
              await categoriesData.editCategorie(categoriesModel, imageFile!);
          statusRequest = handlingData(response);
          if (StatusRequest.success == statusRequest) {
            // Start backend
            if (response['status'] == "success") {
              Get.rawSnackbar(
                  title: "اشعار",
                  messageText: const Text("تم تعديل التصنيف بنجاح "));
              name.text = "";
              namear.text = "";
              imageFile = null;
              isChangeImage = false;
              categoriesModel = CategoriesModel();
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
  }

  selectImageFromGallery() async {
    imageFile = await pickImageFromGallery();
    if (imageFile != null) {
      isChangeImage = true;
      isChangeData = true;
    }
    update();
  }

  selectImageFromCamera() async {
    imageFile = await pickImageFromCamera();
    if (imageFile != null) {
      isChangeImage = true;
      isChangeData = true;
    }
    update();
  }
}
