// ignore_for_file: use_build_context_synchronously

import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:adminkingfashion/core/funcations/validinput.dart';
import 'package:adminkingfashion/core/shaerd/custombutton.dart';
import 'package:adminkingfashion/view/widget/auth/customtxtformauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adminkingfashion/controller/sizes/addsize_controller.dart';
import 'package:adminkingfashion/controller/sizes/viewsize_controller.dart';
import 'package:adminkingfashion/core/class/handlingdataview.dart';

class AddSize extends StatelessWidget {
  const AddSize({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddSizeControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: Text(translateDatabase("أضافة مقاس", "Add Size")),
      ),
      body: SafeArea(
        child: GetBuilder<AddSizeControllerImp>(builder: (controller) {
          return Form(
            key: controller.formstate,
            child: HandlingDataViewRequest(
              statusRequest: controller.statusRequest,
              widget: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextFormAuth(
                    hinttext: translateDatabase(
                        "ادخل اسم المقاس بالعربي", "Enter Size Name In Arabic"),
                    labeltext: translateDatabase("الاسم", "Name"),
                    iconData: Icons.color_lens,
                    mycontroller: controller.namear,
                    valid: (value) {
                      return validInput(value!, 3, 100, "name");
                    },
                    isNumber: false,
                  ),
                  CustomTextFormAuth(
                    hinttext: translateDatabase("ادخل اسم المقاس بالانجليزي",
                        "Enter Size Name In English"),
                    labeltext: translateDatabase("الاسم", "Name"),
                    iconData: Icons.color_lens,
                    mycontroller: controller.name,
                    valid: (value) {
                      return validInput(value!, 3, 100, "username");
                    },
                    isNumber: false,
                  ),
                  CustomButton(
                    textbutton: translateDatabase("أضافة", "Add"),
                    onPressed: () async {
                      await controller.addSize();

                      if (controller.isAdded) {
                        ViewSizesControllerImp controllerView =
                            Get.put(ViewSizesControllerImp());
                        await controllerView.getdata();
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
