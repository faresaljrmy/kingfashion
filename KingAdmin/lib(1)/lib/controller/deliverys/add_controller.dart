import 'dart:io';

import 'package:adminkingfashion/controller/deliverys/view_controller.dart';
import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/core/funcations/handlinfdatacontroller.dart';
import 'package:adminkingfashion/core/funcations/uploadfiles.dart';
import 'package:adminkingfashion/data/datasource/remote/delierys_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DeliverysAddController extends GetxController {
  DeliverysDataRemote deliverysDataRemote = DeliverysDataRemote(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  GlobalKey<FormState> formstatesignup = GlobalKey<FormState>();
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;

  bool isshowpassword = true;

  //  List data =[];

  showpassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  File? file;

  choosUploadFile() async {
    file = await fileUpload(true);
    update();
  }

  adddata() async {
    if (formstatesignup.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      Map data = {
        "deliveryname": username.text,
        "password": password.text,
        "email": email.text,
        "phone": phone.text,
      };
      var response = await deliverysDataRemote.addData(data);
      print("================================= Controller $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.snackbar("نجاح", "تم إضافة عامل توصيل جديد");
          Get.offNamed(AppRoute.deliverysview);
          DeliverysViewController cv = Get.find();
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
    username = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }
}
