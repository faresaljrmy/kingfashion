import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/admin/controller/admin/sizes/editsize_controller.dart';
import 'package:kingfashion/core/class/handlingdataview.dart';
import 'package:kingfashion/core/functions/validinput.dart';
import 'package:kingfashion/core/shared/custombutton.dart';
import 'package:kingfashion/view/widget/auth/customtextformauth.dart';

class EditSize extends StatelessWidget {
  const EditSize({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditSizeControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Size"),
      ),
      body: SafeArea(
        child: GetBuilder<EditSizeControllerImp>(builder: (controller) {
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
                    text: "Edit",
                    onPressed: () async {
                      await controller.editSize();
                      Navigator.pop(context);
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
