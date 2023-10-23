// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:kingfashion/admin/controller/admin/colors/addcolor_controller.dart';
import 'package:kingfashion/admin/controller/admin/colors/viewcolor_controller.dart';
import 'package:kingfashion/core/class/handlingdataview.dart';
import 'package:kingfashion/core/functions/validinput.dart';
import 'package:kingfashion/core/shared/custombutton.dart';
import 'package:kingfashion/view/widget/auth/customtextformauth.dart';

class AddColor extends StatelessWidget {
  const AddColor({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddColorControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Color"),
      ),
      body: SafeArea(
        child: GetBuilder<AddColorControllerImp>(builder: (controller) {
          return Form(
            key: controller.formstate,
            child: HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextFormAuth(
                    hinttext: "ادخل اسم اللون بالعربي",
                    labeltext: "الاسم",
                    iconData: Icons.color_lens,
                    mycontroller: controller.namear,
                    valid: (value) {
                      return validInput(value!, 3, 100, "name");
                    },
                    isNumber: false,
                  ),
                  CustomTextFormAuth(
                    hinttext: "Enter Color Name in English",
                    labeltext: "Name",
                    iconData: Icons.color_lens,
                    mycontroller: controller.name,
                    valid: (value) {
                      return validInput(value!, 3, 100, "username");
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
                      child: const Text("Select Color",
                          style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  CustomButton(
                    text: "Add",
                    onPressed: () async {
                      await controller.addColor();

                      if (controller.isAdded) {
                        ViewColorsControllerImp controllerView =
                            Get.put(ViewColorsControllerImp());
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
