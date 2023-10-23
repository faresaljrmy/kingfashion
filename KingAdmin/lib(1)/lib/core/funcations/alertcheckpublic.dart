import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adminkingfashion/core/constant/colors.dart';

Future<bool> alertCheckPublic(
    {String title = "",
    String middleText = "",
    Function()? onPressedYes,
    Function()? onPressedNo}) async {
  bool isYes = false;

  await Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(
          color: AppColors.primaryColor, fontWeight: FontWeight.bold),
      middleText: middleText,
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.primaryColor)),
            onPressed: onPressedYes ??
                () {
                  isYes = true;
                  Get.back();
                },
            child: Text(translateDatabase("نعم", "Yes"))),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.primaryColor)),
            onPressed: onPressedNo ??
                () {
                  isYes = false;
                  Get.back();
                },
            child: Text(translateDatabase("لا", "No")))
      ]);

  return Future.value(isYes);
}

alertLoadingPublic(BuildContext context) async {
  Get.dialog(
    AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    ),
  );
}
