import 'package:adminkingfashion/controller/items/itemcolorsize/addcoloritem_controller.dart';
import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:adminkingfashion/core/shaerd/custombutton.dart';
import 'package:adminkingfashion/data/model/colormodel.dart';
import 'package:adminkingfashion/view/widget/items/itemcolorsize/customexpansiontileaddcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemsAddColor extends StatelessWidget {
  const ItemsAddColor({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ItemsAddColorController());
    return GetBuilder<ItemsAddColorController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            controller.operation == "add"
                ? translateDatabase("أضافة الوان للمنتج", "Add Colors For Item")
                : translateDatabase(
                    "تعديل الوان المنتج", "Edit Colors For Item"),
          ),
          elevation: 3,
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(10),
          child: CustomButton(
            onPressed: () {
              controller.save(context);
            },
            textbutton: translateDatabase("حفظ الالوان", "Save Colors"),
          ),
        ),
        body: SafeArea(
            child: ListView(
          padding: const EdgeInsets.only(top: 10),
          children: List.generate(controller.selectedListColors.length + 1,
              (indexcolor) {
            if (indexcolor == 0) {
              return Container(
                color: Colors.grey.shade300,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomButton(
                        textbutton: translateDatabase("أضافة", "Add"),
                        onPressed: () {
                          controller.addColor();
                        },
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(blurRadius: 0.5, spreadRadius: 0.5)
                            ]),
                        // padding: const EdgeInsets.all(),
                        child: DropdownButton(
                          // alignment: Alignment.centerLeft,

                          hint: Text(
                              translateDatabase("أختر اللون", "Select Color")),
                          onChanged: (value) {
                            if (value != null) {
                              controller.changeSelectedColor(value.toString());
                            }
                          },
                          value: translateDatabase(
                              controller.selectedColor.nameAr,
                              controller.selectedColor.name),
                          // dropdownColor: Colors.grey.shade200,
                          // padding: const EdgeInsets.all(10),
                          items: List.generate(controller.listColors.length,
                              (indexdrop) {
                            ColorModel colorModel =
                                controller.listColors[indexdrop];
                            return DropdownMenuItem(
                                value: translateDatabase(
                                    colorModel.nameAr, colorModel.name),
                                child: Container(
                                  color: Colors.grey.shade200,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        translateDatabase(
                                            colorModel.nameAr, colorModel.name),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Container(
                                        // height: 20,
                                        width: 30,
                                        padding: const EdgeInsets.all(5),
                                        color: Color(
                                          int.parse(
                                            colorModel.rgb != null
                                                ? colorModel.rgb!.toString()
                                                : "000000",
                                            radix: 16,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              ColorModel color = controller.selectedListColors[indexcolor - 1];
              return CustomExpansionTileAddColor(
                color: color,
                indexcolor: indexcolor - 1,
              );
            }
          }),
        )),
      );
    });
  }
}
