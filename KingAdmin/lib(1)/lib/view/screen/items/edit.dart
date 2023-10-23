import 'package:adminkingfashion/controller/items/edit_controller.dart';
import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:adminkingfashion/core/funcations/alertcheckpublic.dart';
import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:adminkingfashion/core/funcations/validinput.dart';
import 'package:adminkingfashion/core/shaerd/custombutton.dart';
import 'package:adminkingfashion/core/shaerd/customdropdownlist.dart';
import 'package:adminkingfashion/core/shaerd/customtextfilead.dart';
import 'package:adminkingfashion/data/model/colormodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemsEdit extends StatelessWidget {
  const ItemsEdit({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ItemsEditController());
    return Scaffold(
        appBar: AppBar(title: const Text("تعديل المنتج")),
        body: GetBuilder<ItemsEditController>(
          builder: (controller) => Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Form(
              key: controller.formstateeditcate,
              child: ListView(
                children: [
                  controller.file != null
                      ? Card(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Image.file(
                              controller.file!,
                              width: 200,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      : const Text(""),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormGolable(
                    iconData: Icons.interests_outlined,
                    labeltext: "اسم المنتج",
                    isNumber: false,
                    hinttext: 'ادخل اسم المنتج بالإنجليزيه',
                    mycontroller: controller.name,
                    obscureText: null,
                    valid: (val) {
                      return validInput(val!, 50, 3, "");
                    },
                  ),
                  CustomTextFormGolable(
                    iconData: Icons.interests_outlined,
                    labeltext: "اسم المنتج",
                    isNumber: false,
                    hinttext: 'ادخل اسم المنتج بالعربية',
                    mycontroller: controller.namear,
                    obscureText: null,
                    valid: (val) {
                      return validInput(val!, 50, 3, "");
                    },
                  ),
                  CustomTextFormGolable(
                    iconData: Icons.description,
                    labeltext: " الوصف",
                    isNumber: false,
                    hinttext: '  الوصف بالإنجليزيه',
                    mycontroller: controller.description,
                    obscureText: null,
                    valid: (val) {
                      return validInput(val!, 50, 3, "");
                    },
                  ),
                  CustomTextFormGolable(
                    iconData: Icons.description,
                    labeltext: "الوصف",
                    isNumber: false,
                    hinttext: 'الوصف بالعربية',
                    mycontroller: controller.descriptionAr,
                    obscureText: null,
                    valid: (val) {
                      return validInput(val!, 50, 3, "");
                    },
                  ),
                  CustomTextFormGolable(
                    iconData: Icons.numbers,
                    labeltext: "الكمية",
                    isNumber: true,
                    hinttext: 'ادخل كمية المنتج',
                    mycontroller: controller.count,
                    obscureText: null,
                    valid: (val) {
                      return validInput(val!, 50, 1, "");
                    },
                  ),
                  CustomTextFormGolable(
                    iconData: Icons.money,
                    labeltext: "السعر",
                    isNumber: true,
                    hinttext: 'أدخل سعر المنتج',
                    mycontroller: controller.price,
                    obscureText: null,
                    valid: (val) {
                      return validInput(val!, 50, 1, "");
                    },
                  ),
                  CustomTextFormGolable(
                    iconData: Icons.discount,
                    labeltext: " الخصم",
                    isNumber: true,
                    hinttext: 'ادخل الخصم للمنتج ',
                    mycontroller: controller.discount,
                    obscureText: null,
                    valid: (val) {
                      return validInput(val!, 50, 1, "");
                    },
                  ),
                  CustomDropdownSearch(
                    title: "أختر القسم",
                    dropDownListData: controller.dropdownlist,
                    hint: "أضغط لاختيارالقسم",
                    selectedName: controller.catename,
                    selectedId: controller.cateid!,
                    submitbutton: "تم",
                    iconData: Icons.category,
                  ),
                  RadioListTile(
                      title: const Text("إظهار المنتج"),
                      value: "1",
                      groupValue: controller.active,
                      onChanged: (val) {
                        controller.choosActivted(val);
                      }),
                  RadioListTile(
                      title: const Text("إخفاء المنتج"),
                      value: "0",
                      groupValue: controller.active,
                      onChanged: (val) {
                        controller.choosActivted(val);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                          textbutton: "أضافة الوان",
                          onPressed: () async {
                            await controller.goToEditItemColor();
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ListView(
                      padding: const EdgeInsets.all(10),

                      scrollDirection: Axis.horizontal,
                      // reverse: true,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          controller.selectedListColors.length, (index) {
                        ColorModel colorModel =
                            controller.selectedListColors[index];
                        return InkWell(
                          onLongPress: () async {
                            await alertCheckPublic(
                                title: "تنبية",
                                middleText:
                                    "هل تريد حذف التصنيف للتاكيد اضغط نعم للالغاء اضغط لا",
                                onPressedYes: () {
                                  controller.removeColorFromSelected(
                                      colorModel.id.toString());
                                  Get.back();
                                },
                                onPressedNo: () {
                                  Get.back();
                                });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: CustomButton(
                                textbutton: colorModel.name!,
                                color: colorModel.rgb != null
                                    ? Color(
                                        int.parse(colorModel.rgb!, radix: 16))
                                    : AppColors.primaryColor,
                                onPressed: () async {}),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                          textbutton: " أدخل صورة",
                          onPressed: () {
                            controller.choosOptionImage();
                          }),
                      CustomButton(
                          textbutton: translateDatabase("تعديل", "Edit"),
                          onPressed: () {
                            controller.editData();
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
