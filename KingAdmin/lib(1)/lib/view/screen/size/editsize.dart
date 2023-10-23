import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:adminkingfashion/core/funcations/validinput.dart';
import 'package:adminkingfashion/core/shaerd/custombutton.dart';
import 'package:adminkingfashion/view/widget/auth/customtxtformauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adminkingfashion/controller/sizes/editsize_controller.dart';
import 'package:adminkingfashion/core/class/handlingdataview.dart';

class EditSize extends StatelessWidget {
  const EditSize({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditSizeControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: Text(translateDatabase("تعديل مقاس", "Edit Size")),
      ),
      body: SafeArea(
        child: GetBuilder<EditSizeControllerImp>(builder: (controller) {
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
                    textbutton: translateDatabase("تعديل", "Edit"),
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
