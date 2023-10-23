import 'package:adminkingfashion/controller/auth/logincontroller.dart';
import 'package:adminkingfashion/core/class/handlingdataview.dart';

import 'package:adminkingfashion/core/funcations/alertdilogeexit.dart';
import 'package:adminkingfashion/core/funcations/validinput.dart';
import 'package:adminkingfashion/view/widget/auth/cuatomtxttitleauth.dart';
import 'package:adminkingfashion/view/widget/auth/custombtnauth.dart';
import 'package:adminkingfashion/view/widget/auth/customtxtbodyauth.dart';
import 'package:adminkingfashion/view/widget/auth/customtxtformauth.dart';
import 'package:adminkingfashion/view/widget/auth/logoauth.dart';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LogInControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "تسجيل الدخول",
        ),
      ),
      body: WillPopScope(
          onWillPop: alertDialogExit,
          child: GetBuilder<LogInControllerImp>(
            builder: ((controller) => HandlingDataViewRequest(
                statusRequest: controller.statusRequest,
                widget: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: Form(
                      key: controller.formstatelogin,
                      child: ListView(
                        children: [
                          const LogoAuth(),
                          const SizedBox(
                            height: 20,
                          ),
                          const CustomTextTitleAuth(
                            text: "اهلا بك",
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const CustomTextBodyAuth(
                            text:
                                "سجل دخولك في تطبيق توصيل الطلبات لمتجر كل شئ",
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          CustomTextFormAuth(
                            mycontroller: controller.email,
                            hinttext: "أدخل بريدك الإلكتروني ",
                            labeltext: "البريد الإلكتروني",
                            iconData: Icons.email_outlined,
                            obscureText: null,
                            valid: (val) {
                              return validInput(val!, 50, 6, "email");
                            },
                            isNumber: false,
                          ),
                          GetBuilder<LogInControllerImp>(
                            builder: (controller) => CustomTextFormAuth(
                              mycontroller: controller.password,
                              hinttext: "ادخل كلمة المرور",
                              labeltext: "الباسورد",
                              iconData: Icons.lock_outline,
                              valid: (val) {
                                return validInput(val!, 20, 6, "password");
                              },
                              onTapIcon: () {
                                controller.showpassword();
                              },
                              obscureText: controller.isshowpassword,
                              isNumber: false,
                            ),
                          ),
                          InkWell(
                              onTap: (() {
                                controller.goToForgetPassword();
                              }),
                              child: const Text(
                                "هل نسيت كلمة المرور",
                                textAlign: TextAlign.end,
                              )),
                          CustomButtonAuth(
                            textbutton: "تسجيل دخول",
                            onPressed: () async {
                              await controller.login();
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )))),
          )),
    );
  }
}
