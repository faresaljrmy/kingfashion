import 'package:adminkingfashion/core/localization/changelocallangcontroller.dart';
import 'package:adminkingfashion/core/services/services.dart';
import 'package:get/get.dart';

class SetteingsPageController extends GetxController {
  MyServices myServices = Get.find();

  LocaleController localeController = Get.find();

  changeLang(String langcode) {
    myServices.sharedPreferences.setString("lang", langcode);

    Get.back();
    update();
  }
}
