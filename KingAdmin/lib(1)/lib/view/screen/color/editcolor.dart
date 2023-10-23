// ignore_for_file: use_build_context_synchronously

import 'package:adminkingfashion/controller/colors/editcolor_controller.dart';
import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:adminkingfashion/core/funcations/validinput.dart';
import 'package:adminkingfashion/core/shaerd/custombutton.dart';
import 'package:adminkingfashion/view/widget/auth/customtxtformauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:adminkingfashion/core/class/handlingdataview.dart';

class EditColor extends StatelessWidget {
  const EditColor({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditColorControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: Text(translateDatabase("تعديل لون", "Edit Color")),
      ),
      body: SafeArea(
        child: GetBuilder<EditColorControllerImp>(builder: (controller) {
          return Form(
            key: controller.formstate,
            child: HandlingDataViewRequest(
              statusRequest: controller.statusRequest,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextFormAuth(
                    hinttext: translateDatabase(
                        "ادخل اسم اللون بالعربي", "Enter Color Name In Arabic"),
                    labeltext: translateDatabase("الاسم", "Name"),
                    iconData: Icons.color_lens,
                    mycontroller: controller.namear,
                    valid: (value) {
                      return validInput(value!, 100, 3, "name");
                    },
                    isNumber: false,
                  ),
                  CustomTextFormAuth(
                    hinttext: translateDatabase("ادخل اسم اللون بالانجليزي",
                        "Enter Color Name In English"),
                    labeltext: translateDatabase("الاسم", "Name"),
                    iconData: Icons.color_lens,
                    mycontroller: controller.name,
                    valid: (value) {
                      return validInput(value!, 100, 3, "username");
                    },
                    isNumber: false,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, right: 20, left: 20),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      onPressed: () async {
                        showDialog(
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Pick a color!'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: controller.pickerColor,
                                  onColorChanged: (color) {
                                    controller.pickerColor = color;
                                    //  print(color.toString());
                                  },
                                ),
                                // Use Material color picker:
                                //
                                // child: MaterialPicker(
                                //   pickerColor: pickerColor,
                                //   onColorChanged: changeColor,
                                //   showLabel: true, // only on portrait mode
                                // ),
                                //
                                // Use Block color picker:
                                //
                                // child: BlockPicker(
                                //   pickerColor: currentColor,
                                //   onColorChanged: changeColor,
                                // ),
                                //
                                // child: MultipleChoiceBlockPicker(
                                //   pickerColors: currentColors,
                                //   onColorsChanged: changeColors,
                                // ),
                              ),
                              actions: [
                                ElevatedButton(
                                  child: const Text('Got it'),
                                  onPressed: () {
                                    controller.changeColor();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                          context: context,
                        );
                      },
                      color: controller.currentColor,
                      textColor: Colors.white,
                      child: Text(translateDatabase("اختر لون", "Select Color"),
                          style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                  CustomButton(
                    textbutton: translateDatabase("تعديل", "Edit"),
                    onPressed: () async {
                      await controller.editColor();
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
