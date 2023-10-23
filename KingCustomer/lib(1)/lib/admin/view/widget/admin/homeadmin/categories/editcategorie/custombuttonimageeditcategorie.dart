import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/admin/controller/admin/categories/editcategorie_controller.dart';
import 'package:kingfashion/core/constant/color.dart';
import 'package:kingfashion/core/shared/custombutton.dart';

class CustomButtonSelectImageEditCateg extends StatelessWidget {
  const CustomButtonSelectImageEditCateg({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditCategorieControllerImp>(builder: (controller) {
      return Container(
        width: 200,
        margin: const EdgeInsets.only(top: 10, right: 20, left: 20),
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(vertical: 5),
          onPressed: () async {
            await Get.bottomSheet(
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomButton(
                    text: "From Gallery",
                    onPressed: () async {
                      await controller.selectImageFromGallery();
                    },
                  ),
                  CustomButton(
                    text: "From Camera",
                    onPressed: () async {
                      await controller.selectImageFromCamera();
                    },
                  )
                ],
              ),
              backgroundColor: Colors.white,

              // useRootNavigator: false
              // enableDrag: true,
            );

            // showBottomSheet(
            //     context: context,
            //     builder: (context) {
            //       return Column(
            //         children: [
            //           CustomButton(
            //             text: "From Gallery",
            //             onPressed: () async {
            //               await controller.selectImageFromGallery();
            //             },
            //           ),
            //           CustomButton(
            //             text: "From Camera",
            //             onPressed: () async {
            //               await controller.selectImageFromCamera();
            //             },
            //           )
            //         ],
            //       );

            //     });
          },
          color:
              controller.isChangeImage ? Colors.green : AppColor.primaryColor,
          textColor: Colors.white,
          child: const Text("Select Image", style: TextStyle(fontSize: 16)),
        ),
      );
    });
  }
}
