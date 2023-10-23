import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:kingfashion/core/class/statusrequest.dart';
import 'package:kingfashion/core/constant/routes.dart';
import 'package:kingfashion/core/functions/handingdatacontroller.dart';
import 'package:kingfashion/data/datasource/remote/auth/signupdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class SignUpController extends GetxController {
  signUp();
  goToSignIn();
  pickImageFromGallery();
  pickImageFromCamera();
}

class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController shop;
  late TextEditingController address;
  late TextEditingController phone;
  late TextEditingController password;

  File? imageFile;
  final picker = ImagePicker();

  StatusRequest statusRequest = StatusRequest.none;

  SignupData signupData = SignupData(Get.find());

  List data = [];

  @override
  signUp() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response;
      if (imageFile != null) {
        response = await signupData.postDataWithImage(
            username.text.trim(),
            email.text.trim(),
            shop.text.trim(),
            address.text.trim(),
            phone.text.trim(),
            password.text.trim(),
            imageFile!);
      } else {
        response = await signupData.postdata(
            username.text.trim(),
            email.text.trim(),
            shop.text.trim(),
            address.text.trim(),
            phone.text.trim(),
            password.text.trim());
      }
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // data.addAll(response['data']);
          await Get.defaultDialog(title: "37".tr, middleText: "38".tr);
          // Get.offNamed(AppRoute.verfiyCodeSignUp,
          //     arguments: {"email": email.text});
        } else {
          Get.defaultDialog(
              title: "ُWarning",
              middleText: "Phone Number Or Email Already Exists");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {}
  }

  @override
  goToSignIn() {
    Get.offNamed(AppRoute.login);
  }

  @override
  pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      update();
      // users.image = imageFile;
    }
  }

  @override
  pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      // maxHeight: 200,
      // maxWidth: 200,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      update();
      // users.image = imageFile;
    }
  }

  @override
  void onInit() {
    username = TextEditingController(text: "");
    phone = TextEditingController(text: "");
    email = TextEditingController(text: "");
    shop = TextEditingController(text: "");
    address = TextEditingController(text: "");
    password = TextEditingController(text: "");
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    shop.dispose();
    address.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }
}
