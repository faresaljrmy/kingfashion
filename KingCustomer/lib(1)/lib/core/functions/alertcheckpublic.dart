import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/core/constant/color.dart';

Future<bool> alertCheckPublic(
    {String title = "",
    String middleText = "",
    Function()? onPressedYes,
    Function()? onPressedNo}) async {
  await Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(
          color: AppColor.primaryColor, fontWeight: FontWeight.bold),
      middleText: middleText,
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColor.primaryColor)),
            onPressed: onPressedYes,
            child: const Text("نعم")),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColor.primaryColor)),
            onPressed: onPressedNo,
            child: const Text("لا"))
      ]);

  return Future.value(true);
}
