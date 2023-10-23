import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/admin/controller/admin/categories/addcategorie_controller.dart';
import 'package:kingfashion/core/constant/color.dart';
import 'package:kingfashion/core/shared/custombutton.dart';

class CustomButtonSelectImageAddCateg extends StatelessWidget {
  const CustomButtonSelectImageAddCateg({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCategorieControllerImp>(builder: (controller) {
      return Container(
        width: 200,
        margin: const EdgeInsets.only(top: 10, right: 20, left: 20),
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(vertical: 5),
          onPressed: () async {
            showBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
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
                  );
                });
          },
          color:
              controller.selectedImage ? Colors.green : AppColor.primaryColor,
          textColor: Colors.white,
          child: const Text("Select Image", style: TextStyle(fontSize: 16)),
        ),
      );
    });
  }
}
