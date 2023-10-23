import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/core/constant/color.dart';
import 'package:kingfashion/core/constant/routes.dart';
import 'package:kingfashion/core/services/services.dart';

Future<bool> alertSignOut() async {
  await Get.defaultDialog(
      title: "تنبيه",
      titleStyle: const TextStyle(
          color: AppColor.primaryColor, fontWeight: FontWeight.bold),
      middleText: "هل تريد تسجيل الخروج من التطبيق",
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColor.primaryColor)),
            onPressed: () {
              MyServices myServices = Get.find();
              // myServices.sharedPreferences.clear();
              myServices.sharedPreferences.remove("id");
              myServices.sharedPreferences.remove("username");
              myServices.sharedPreferences.remove("email");
              myServices.sharedPreferences.remove("phone");
              myServices.sharedPreferences.remove("usr_type");
              myServices.sharedPreferences.setString("step", "1");

              Get.offAllNamed(AppRoute.login);
            },
            child: const Text("تسجيل الخروج")),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColor.primaryColor)),
            onPressed: () {
              Get.back();
            },
            child: const Text("الغاء"))
      ]);
  return Future.value(true);
}
