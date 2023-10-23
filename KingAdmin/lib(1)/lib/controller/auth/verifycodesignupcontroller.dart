import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/core/funcations/handlinfdatacontroller.dart';
import 'package:adminkingfashion/data/datasource/remote/auth/verifycodedata.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

abstract class VerifyCodeSignUpController extends GetxController {
  checkCode(String verificadoSignup);
  reSendCode();
}

class VerifyCodeSignUpControllerImp extends VerifyCodeSignUpController {
  VerifyCodeSignupDataRemote verifyCodeSignupDataRemote =
      VerifyCodeSignupDataRemote(Get.find());

  String? email;
  StatusRequest statusRequest = StatusRequest.none;

  @override
  checkCode(verificadoSignup) async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await verifyCodeSignupDataRemote.postData(email!, verificadoSignup);
    print("=================== controller  $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response["status"] == "success") {
        Get.offNamed(AppRoute.successSignUp);
      } else {
        Get.defaultDialog(
            title: "warrning", middleText: "VerifyCode Not Correct");
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    email = Get.arguments["email"];
    super.onInit();
  }

  @override
  reSendCode() {
    verifyCodeSignupDataRemote.reSendData(email!);
  }
}
