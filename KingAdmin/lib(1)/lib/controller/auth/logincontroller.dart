import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/core/funcations/handlinfdatacontroller.dart';
import 'package:adminkingfashion/core/services/services.dart';
import 'package:adminkingfashion/data/datasource/remote/auth/logindata.dart';
import 'package:flutter/cupertino.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

abstract class LogInController extends GetxController {
  login();
  goTosignup();
  goToForgetPassword();
}

class LogInControllerImp extends LogInController {
  bool isshowpassword = true;

  showpassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  LoginDataRemote loginDataRemote = LoginDataRemote(Get.find());
  MyServices myServices = Get.find();
  GlobalKey<FormState> formstatelogin = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;

  StatusRequest statusRequest = StatusRequest.none;

  @override
  login() async {
    if (formstatelogin.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginDataRemote.postData(
        email.text,
        password.text,
      );
      print("=================== controller  $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response["status"] == "success") {
          //  data.addAll(response['data']);
          if (response["data"]["type"].toString() == "1") {
            myServices.sharedPreferences
                .setString("id", response["data"]["id"].toString());
            String adminid = myServices.sharedPreferences.getString("id")!;
            myServices.sharedPreferences
                .setString("username", response["data"]["name"]);
            myServices.sharedPreferences
                .setString("email", response["data"]["email"]);
            myServices.sharedPreferences
                .setString("phone", response["data"]["phone"]);
            myServices.sharedPreferences.setString("step", "1");
            FirebaseMessaging.instance.subscribeToTopic("serveces");
            FirebaseMessaging.instance.subscribeToTopic("serveces$adminid");

            Get.offAllNamed(AppRoute.dashboard);
          } else {
            Get.offNamed(AppRoute.verfiyCodeSignUp,
                arguments: {"email": email.text});
          }
        } else {
          Get.defaultDialog(
              title: "warrning", middleText: " Email or Password Not Correct");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    }
  }

  @override
  goTosignup() {
    // Get.toNamed(AppRoute.signUp);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }
}
