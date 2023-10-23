import 'package:kingfashion/core/class/statusrequest.dart';
import 'package:kingfashion/core/constant/routes.dart';
import 'package:kingfashion/core/functions/handingdatacontroller.dart';
import 'package:kingfashion/core/services/services.dart';
import 'package:kingfashion/data/datasource/remote/auth/login.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  goToForgetPassword();
}

class LoginControllerImp extends LoginController {
  LoginData loginData = LoginData(Get.find());

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;

  bool isshowpassword = true;

  MyServices myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;

  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  @override
  login() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginData.postdata(email.text, password.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // data.addAll(response['data']);
          if (response['data']['type'].toString() == "1" ||
              response['data']['type'].toString() == "2") {
            myServices.sharedPreferences
                .setString("id", response['data']['id']);
            myServices.sharedPreferences
                .setString("username", response['data']['name']);
            myServices.sharedPreferences
                .setString("email", response['data']['email']);
            myServices.sharedPreferences
                .setString("phone", response['data']['phone']);
            myServices.sharedPreferences.setString("step", "2");
            myServices.sharedPreferences
                .setString("type", response['data']['type'].toString());
            // FirebaseMessaging.instance.subscribeToTopic("users");
            // FirebaseMessaging.instance.subscribeToTopic("users$userid");
            // await Get.defaultDialog(title: "Welcome", middleText: "Welcome to King City");
            if (response['data']['type'].toString() == "1") {
              Get.offNamed(AppRoute.adminhomepage);
            } else {
              Get.offNamed(AppRoute.homepage);
            }
          } else if (response['data']['type'].toString() == "0") {
            await Get.defaultDialog(title: "37".tr, middleText: "38".tr);
            // Get.toNamed(AppRoute.verfiyCodeSignUp,
            //     arguments: {"email": email.text});
          } else {
            await Get.defaultDialog(title: "43".tr, middleText: "44".tr);
            // Get.toNamed(AppRoute.verfiyCodeSignUp,
            //     arguments: {"email": email.text});
          }
        } else {
          Get.defaultDialog(
              title: "ُWarning", middleText: "Email Or Password Not Correct");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {}
  }

  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signUp);
  }

  @override
  void onInit() {
    // FirebaseMessaging.instance.getToken().then((value) {
    //   print(value);
    //   String? token = value;
    // });
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
