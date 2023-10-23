// ignore: depend_on_referenced_packages
import 'package:adminkingfashion/core/constant/routes.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

abstract class SuccssSignUpController extends GetxController {
  goToLogin();
}

class SuccssSignUpControllerImp extends SuccssSignUpController {
  @override
  goToLogin() {
    Get.offNamed(AppRoute.login);
  }
}
