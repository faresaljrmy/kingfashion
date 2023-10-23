import 'package:adminkingfashion/controller/deliverys/add_controller.dart';
import 'package:adminkingfashion/core/class/handlingdataview.dart';
import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:adminkingfashion/core/funcations/validinput.dart';
import 'package:adminkingfashion/view/widget/auth/cuatomtxttitleauth.dart';
import 'package:adminkingfashion/view/widget/auth/custombtnauth.dart';
import 'package:adminkingfashion/view/widget/auth/customtxtformauth.dart';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class DeliveryAdd extends StatelessWidget {
  const DeliveryAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DeliverysAddController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.backgroundcolor,
        elevation: 0.0,
        title: Text(
          "إظافة عامل توصيل جديد",
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(color: AppColors.grey),
        ),
      ),
      body: GetBuilder<DeliverysAddController>(
          builder: (controller) => HandlingDataViewRequest(
              statusRequest: controller.statusRequest,
              widget: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Form(
                    key: controller.formstatesignup,
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextTitleAuth(
                          text: "أدخل البيانات".tr,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // CustomTextBodyAuth(
                        //   text: "24".tr,
                        // ),
                        const SizedBox(
                          height: 35,
                        ),
                        CustomTextFormAuth(
                          mycontroller: controller.username,
                          hinttext: "اسم العامل".tr,
                          labeltext: "الإسم".tr,
                          iconData: Icons.person_outline,
                          obscureText: null,
                          valid: (val) {
                            return validInput(val!, 15, 4, "");
                          },
                          isNumber: false,
                        ),
                        CustomTextFormAuth(
                          mycontroller: controller.email,
                          hinttext: "لبريد الإلكتروني".tr,
                          labeltext: "البريد الإلكتروني".tr,
                          iconData: Icons.email_outlined,
                          obscureText: null,
                          valid: ((val) {
                            return validInput(val!, 50, 6, "email");
                          }),
                          isNumber: false,
                        ),
                        CustomTextFormAuth(
                          mycontroller: controller.phone,
                          hinttext: "رقم الجوال".tr,
                          labeltext: "الجوال".tr,
                          iconData: Icons.phone_android_outlined,
                          valid: (val) {
                            return validInput(val!, 12, 9, "phone");
                          },
                          onTapIcon: () {},
                          isNumber: true,
                        ),
                        GetBuilder<DeliverysAddController>(
                          builder: (controller) => CustomTextFormAuth(
                            mycontroller: controller.password,
                            hinttext: "كلمة المرور".tr,
                            labeltext: "كلمة المرور".tr,
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

                        CustomButtonAuth(
                          textbutton: "إظافة".tr,
                          onPressed: () {
                            controller.adddata();
                          },
                        ),
                        //  const SizedBox(height: 20,),
                        // CustomTextSinUpandSinIn(
                        //   textOne: "25".tr,
                        //   textTow: "9".tr,
                        //   onTap: (){controller.signup();},
                        // )
                      ],
                    ),
                  )))),
    );
  }
}
