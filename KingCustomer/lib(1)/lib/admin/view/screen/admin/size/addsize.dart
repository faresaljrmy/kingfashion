// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/admin/controller/admin/sizes/addsize_controller.dart';
import 'package:kingfashion/admin/controller/admin/sizes/viewsize_controller.dart';
import 'package:kingfashion/core/class/handlingdataview.dart';
import 'package:kingfashion/core/functions/validinput.dart';
import 'package:kingfashion/core/shared/custombutton.dart';
import 'package:kingfashion/view/widget/auth/customtextformauth.dart';

class AddSize extends StatelessWidget {
  const AddSize({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddSizeControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Size"),
      ),
      body: SafeArea(
        child: GetBuilder<AddSizeControllerImp>(builder: (controller) {
          return Form(
            key: controller.formstate,
            child: HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextFormAuth(
                    hinttext: "ادخل اسم المقاس بالعربي",
                    labeltext: "الاسم",
                    iconData: Icons.color_lens,
                    mycontroller: controller.namear,
                    valid: (value) {
                      return validInput(value!, 3, 100, "name");
                    },
                    isNumber: false,
                  ),
                  CustomTextFormAuth(
                    hinttext: "Enter Size Name in English",
                    labeltext: "Name",
                    iconData: Icons.color_lens,
                    mycontroller: controller.name,
                    valid: (value) {
                      return validInput(value!, 3, 100, "username");
                    },
                    isNumber: false,
                  ),
                  CustomButton(
                    text: "Add",
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
