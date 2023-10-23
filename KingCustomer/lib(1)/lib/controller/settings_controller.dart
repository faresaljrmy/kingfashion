import 'package:kingfashion/core/constant/routes.dart';
import 'package:kingfashion/core/services/services.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  MyServices myServices = Get.find();

  logout() {
    // FirebaseMessaging.instance.unsubscribeFromTopic("users");
    // FirebaseMessaging.instance.unsubscribeFromTopic("users$userid");
    myServices.sharedPreferences.clear();
    Get.offAllNamed(AppRoute.login);
  }
}
