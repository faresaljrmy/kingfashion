import 'package:adminkingfashion/controller/categories/add_controller.dart';
import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:adminkingfashion/core/funcations/validinput.dart';
import 'package:adminkingfashion/core/shaerd/custombutton.dart';
import 'package:adminkingfashion/core/shaerd/customtextfilead.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoriesAdd extends StatelessWidget {
  const CategoriesAdd({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CategoresAddController());
    return Scaffold(
        appBar: AppBar(
            title: Text(translateDatabase("أضافة قسم", "Add Categorie"))),
        body: GetBuilder<CategoresAddController>(
          builder: (controller) => Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Form(
              key: controller.formstateaddcate,
              child: ListView(
                children: [
                  controller.file != null
                      ? Card(
                          child: SvgPicture.file(
                            controller.file!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.contain,
                            color: AppColors.thirdColor,
                          ),
                        )
                      : const Text(""),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormGolable(
                    iconData: Icons.category,
                    labeltext: translateDatabase("اسم القسم", "Categorie Name"),
                    isNumber: false,
                    hinttext: translateDatabase('ادخل اسم القسم بالإنجليزيه',
                        "Enter Categorie Name By English"),
                    mycontroller: controller.name,
                    obscureText: null,
                    valid: (val) {
                      return validInput(val!, 50, 3, "");
                    },
                  ),
                  CustomTextFormGolable(
                    iconData: Icons.category,
                    labeltext: translateDatabase("اسم القسم", "Categorie Name"),
                    isNumber: false,
                    hinttext: translateDatabase('ادخل اسم القسم بالعربية',
                        "Enter Categorie Name By Arabic"),
                    mycontroller: controller.namear,
                    obscureText: null,
                    valid: (val) {
                      return validInput(val!, 50, 3, "");
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                          textbutton: translateDatabase(" أدخل صورة بصيغة:svg",
                              "Enter Image in SVG Format"),
                          onPressed: () {
                            controller.choosUploadFile();
                          }),
                      CustomButton(
                          textbutton: translateDatabase("أضافة", "Add"),
                          onPressed: () {
                            controller.adddata();
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
