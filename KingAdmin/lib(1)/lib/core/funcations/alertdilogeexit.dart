// ignore: depend_on_referenced_packages
import 'dart:io';

import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

Future<bool> alertDialogExit() {
  Get.defaultDialog(
      title: "46".tr,
      middleText: "47".tr,
      radius: 30.0,
      titleStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: AppColors.primaryColor),
      textCancel: "No",
      cancelTextColor: AppColors.primaryColor,
      onConfirm: (() => exit(0)),
      backgroundColor: AppColors.backgroundcolor,
      confirmTextColor: Colors.white,
      buttonColor: AppColors.primaryColor);
  return Future.value(true);
}
