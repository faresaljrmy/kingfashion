import 'package:adminkingfashion/core/constant/apptheme.dart';
import 'package:adminkingfashion/core/funcations/fcmconfige.dart';
import 'package:adminkingfashion/core/services/services.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class LocaleController extends GetxController {
  Locale? language;

  MyServices myServices = Get.find();

  ThemeData apptheme = themeArabic;

  String langcode = "ar";

  changeLang(String langcode) {
    Locale locale = Locale(langcode);

    myServices.sharedPreferences.setString("lang", langcode);
    apptheme = langcode == "ar" ? themeArabic : themeEnglish;
    Get.changeTheme(apptheme);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    requestPermissionNotification();
    fcmconfig();
    String? sharedprefLang = myServices.sharedPreferences.getString("lang");

    if (sharedprefLang == "ar") {
      language = const Locale("ar");
      apptheme = themeArabic;
    } else if (sharedprefLang == "en") {
      language = const Locale("en");
      apptheme = themeEnglish;
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
      apptheme = themeEnglish;
    }

    super.onInit();
  }
}
