import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:adminkingfashion/core/funcations/custombuttonlanguage.dart';
import 'package:adminkingfashion/core/localization/changelocallangcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> showDialogChangeLanguage(
    {String title = "",
    String middleText = "",
    Function()? onPressedYes,
    Function()? onPressedNo}) async {
  bool isYes = false;
  LocaleController controller = Get.put(LocaleController());
  await Get.defaultDialog(
    title: title,
    titleStyle: const TextStyle(
        color: AppColors.primaryColor, fontWeight: FontWeight.bold),
    middleText: middleText,
    actions: [
      Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("1".tr,
                  style: Theme.of(Get.context!).textTheme.displayLarge),
              const SizedBox(height: 20),
              CustomButtonLang(
                  textbutton: "Ar",
                  onPressed: () {
                    controller.changeLang("ar");
                    Get.back();
                    // Get.toNamed(AppRoute.onBoarding);
                  }),
              CustomButtonLang(
                  textbutton: "En",
                  onPressed: () {
                    controller.changeLang("en");
                    Get.back();
                    // Get.toNamed(AppRoute.onBoarding);
                  }),
            ],
          )),
    ],
  );

  return Future.value(isYes);
}
