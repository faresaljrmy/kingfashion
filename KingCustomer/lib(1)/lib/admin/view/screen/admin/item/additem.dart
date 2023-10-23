import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kingfashion/admin/controller/admin/items/additem_controller.dart';
import 'package:kingfashion/admin/controller/admin/items/viewitems_controller.dart';
import 'package:kingfashion/core/class/handlingdataview.dart';
import 'package:kingfashion/core/constant/color.dart';
import 'package:kingfashion/core/functions/validinput.dart';
import 'package:kingfashion/core/shared/custombutton.dart';
import 'package:kingfashion/admin/view/widget/admin/homeadmin/categories/addcategorie/custombuttonimageaddcategorie.dart';
import 'package:kingfashion/view/widget/auth/customtextformauth.dart';

class AddItems extends StatelessWidget {
  const AddItems({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddItemControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Item"),
      ),
      body: SafeArea(
        child: GetBuilder<AddItemControllerImp>(builder: (controller) {
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
                    hinttext: "ادخل اسم التصنيف بالعربي",
                    labeltext: "الاسم",
                    iconData: Icons.category,
                    mycontroller: controller.namear,
                    valid: (value) {
                      return validInput(value!, 3, 100, "name");
                    },
                    isNumber: false,
                  ),
                  CustomTextFormAuth(
                    hinttext: "Enter Item Name in English",
                    labeltext: "Name",
                    iconData: Icons.category,
                    mycontroller: controller.name,
                    valid: (value) {
                      return validInput(value!, 3, 100, "username");
                    },
                    isNumber: false,
                  ),
                  controller.selectedImage
                      ? Row(
                          children: [
                            const Expanded(
                                child: CustomButtonSelectImageAddCateg()),
                            Expanded(
                              child: Container(
                                width: 200,
                                margin: const EdgeInsets.only(
                                    top: 10, right: 20, left: 20),
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  onPressed: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: controller.imageFile!.path
                                                    .endsWith(".svg")
                                                ? SvgPicture.file(
                                                    controller.imageFile!)
                                                : Image.file(
                                                    controller.imageFile!),
                                          );
                                        });
                                  },
                                  color: controller.selectedImage
                                      ? Colors.green
                                      : AppColor.primaryColor,
                                  textColor: Colors.white,
                                  child: const Text("Show Image",
                                      style: TextStyle(fontSize: 16)),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const CustomButtonSelectImageAddCateg(),
                  GetBuilder<ViewItemsControllerImp>(builder: (controllerView) {
                    return CustomButton(
                      text: "Add",
                      onPressed: () async {
                        await controller.addItem();
                        if (controller.isAdded) {
                          await controllerView.getdata();
                          Navigator.pop(context);
                        }
                      },
                    );
                  })
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
