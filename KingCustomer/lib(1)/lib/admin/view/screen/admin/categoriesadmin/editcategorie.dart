import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kingfashion/admin/controller/admin/categories/editcategorie_controller.dart';
import 'package:kingfashion/admin/controller/admin/categories/viewcategories_controller.dart';
import 'package:kingfashion/core/class/handlingdataview.dart';
import 'package:kingfashion/core/constant/color.dart';
import 'package:kingfashion/core/functions/validinput.dart';
import 'package:kingfashion/core/shared/custombutton.dart';
import 'package:kingfashion/linkapi.dart';
import 'package:kingfashion/admin/view/widget/admin/homeadmin/categories/editcategorie/custombuttonimageeditcategorie.dart';
import 'package:kingfashion/view/widget/auth/customtextformauth.dart';

class EditCategorie extends StatelessWidget {
  const EditCategorie({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditCategorieControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Categorie"),
      ),
      body: SafeArea(
        child: GetBuilder<EditCategorieControllerImp>(builder: (controller) {
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
                    hinttext: "Enter Categorie Name in English",
                    labeltext: "Name",
                    iconData: Icons.category,
                    mycontroller: controller.name,
                    valid: (value) {
                      return validInput(value!, 3, 100, "username");
                    },
                    isNumber: false,
                  ),
                  controller.isChangeImage
                      ? Row(
                          children: [
                            const Expanded(
                                child: CustomButtonSelectImageEditCateg()),
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
                                    if (controller.imageFile != null) {
                                      await showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                                content: controller.imageFile !=
                                                        null
                                                    ? controller.imageFile!.path
                                                            .endsWith(".svg")
                                                        ? SvgPicture.file(
                                                            controller
                                                                .imageFile!)
                                                        : Image.file(controller
                                                            .imageFile!)
                                                    : Container());
                                          });
                                    }
                                  },
                                  color: controller.imageFile != null
                                      ? Colors.green
                                      : AppColor.primaryColor,
                                  textColor: Colors.white,
                                  child: const Text("New Image",
                                      style: TextStyle(fontSize: 16)),
                                ),
                              ),
                            ),
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
                                              content: controller
                                                          .categoriesModel
                                                          .image !=
                                                      null
                                                  ? controller
                                                          .categoriesModel.image
                                                          .endsWith(".svg")
                                                      ? SvgPicture.network(
                                                          "${AppLink.imagestCategories}/${controller.categoriesModel.image}")
                                                      : Image.network(
                                                          "${AppLink.imagestCategories}/${controller.categoriesModel.image}")
                                                  : Container());
                                        });
                                  },
                                  color: controller.isChangeImage
                                      ? Colors.green
                                      : AppColor.primaryColor,
                                  textColor: Colors.white,
                                  child: const Text("Old Image ",
                                      style: TextStyle(fontSize: 16)),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const CustomButtonSelectImageEditCateg(),
                  controller.isChangeData
                      ? GetBuilder<ViewCategoriesControllerImp>(
                          builder: (controllerView) {
                          return CustomButton(
                            text: "Edit",
                            onPressed: () async {
                              await controller.editCategorie();

                              if (controller.isNeddEdit) {
                                await controllerView.getdata();
                                Get.back();

                                // await Get.offNamed(
                                //     AppLink.categoriesViewPage);
                              }
                            },
                          );
                        })
                      : Container(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
