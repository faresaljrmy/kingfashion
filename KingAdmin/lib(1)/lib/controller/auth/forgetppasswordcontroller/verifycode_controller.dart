import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/core/funcations/handlinfdatacontroller.dart';
import 'package:adminkingfashion/data/datasource/remote/auth/forgetpassword/verifycodedata.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

abstract class VerifyCodeController extends GetxController {
  checkCode(String verificadoSignup);
  goToResetpassword();
}

class VerifyCodeControllerImp extends VerifyCodeController {
  VerifyCodeDataRemote verifyCodeDataRemote = VerifyCodeDataRemote(Get.find());

  String? email;
  StatusRequest statusRequest = StatusRequest.none;

  @override
  checkCode(verificadoSignup) async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await verifyCodeDataRemote.postData(email!, verificadoSignup);
    print("=================== controller  $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response["status"] == "success") {
        Get.toNamed(AppRoute.resetPassword, arguments: {"email": email});
      } else {
        Get.defaultDialog(
            title: "warrning", middleText: "VerifyCode Not Correct");
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  goToResetpassword() {
    Get.toNamed(AppRoute.resetPassword);
  }

  @override
  void onInit() {
    email = Get.arguments["email"];
    super.onInit();
  }
}
