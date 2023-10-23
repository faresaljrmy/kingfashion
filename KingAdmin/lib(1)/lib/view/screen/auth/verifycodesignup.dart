import 'package:adminkingfashion/controller/auth/verifycodesignupcontroller.dart';
import 'package:adminkingfashion/core/class/handlingdataview.dart';
import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:adminkingfashion/view/widget/auth/cuatomtxttitleauth.dart';
import 'package:adminkingfashion/view/widget/auth/customtxtbodyauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class VerifyCodeSignUp extends StatelessWidget {
  const VerifyCodeSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(VerifyCodeSignUpControllerImp());

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.backgroundcolor,
          elevation: 0.0,
          title: Text(
            "50".tr,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: AppColors.grey),
          ),
        ),
        body: GetBuilder<VerifyCodeSignUpControllerImp>(
            builder: (controller) => HandlingDataViewRequest(
                  statusRequest: controller.statusRequest,
                  widget: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      child: ListView(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextTitleAuth(text: "51".tr),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextBodyAuth(text: "52".tr),
                          const SizedBox(
                            height: 35,
                          ),
                          OtpTextField(
                            borderRadius: BorderRadius.circular(20),
                            fieldWidth: 50.0,
                            numberOfFields: 5,
                            borderColor: AppColors.primaryColor,
                            //set to true to show as box or false to show as dash
                            showFieldAsBox: true,
                            //runs when a code is typed in
                            onCodeChanged: (String code) {
                              //handle validation or checks here
                            },
                            //runs when every textfield is filled
                            onSubmit: (String verificationCode) {
                              Get.offNamed(
                                  controller.checkCode(verificationCode));
                            }, // end onSubmit
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                              onTap: () {
                                controller.reSendCode();
                              },
                              child: const Center(
                                child: Text(
                                  "Resend verificationCode",
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 18),
                                ),
                              ))
                        ],
                      )),
                )));
  }
}
