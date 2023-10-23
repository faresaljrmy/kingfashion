import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kingfashion/admin/controller/admin/categories/viewcategories_controller.dart';
import 'package:kingfashion/core/class/handlingdataview.dart';
import 'package:kingfashion/core/functions/alertcheckpublic.dart';
import 'package:kingfashion/core/functions/translatefatabase.dart';
import 'package:kingfashion/data/model/categoriesmodel.dart';
import 'package:kingfashion/linkapi.dart';

class ViewAllCategoriesAdmin extends StatelessWidget {
  const ViewAllCategoriesAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    // ViewCategoriesControllerImp controller =
    Get.put(ViewCategoriesControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: Text("adminCat".tr),
      ),
      floatingActionButton:
          GetBuilder<ViewCategoriesControllerImp>(builder: (controller) {
        return FloatingActionButton(
          onPressed: () {
            controller.goToAddCategorie();
          },
          child: const Icon(Icons.add),
        );
      }),
      body: SafeArea(
        child: GetBuilder<ViewCategoriesControllerImp>(
          builder: (controller) {
            return HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Container(
                color: Colors.grey.shade200,
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: controller.listCateg.length,
                    itemBuilder: (context, index) {
                      CategoriesModel categorie = controller.listCateg[index];
                      int count = 0;
                      for (var item in controller.listItems) {
                        if (item.itemsCat == categorie.id) {
                          count++;
                        }
                      }
                      return Container(
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 10),
                        height: 100,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: categorie.image.toString().endsWith(".svg")
                                  ? SvgPicture.network(
                                      "${AppLink.imagestCategories}/${categorie.image}")
                                  : Image.network(
                                      "${AppLink.imagestCategories}/${categorie.image}"),
                              // SvgPicture.network(
                              //     "${AppLink.imagestCategories}/${categorie.image}",
                              //     color: AppColor.secondColor),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      translateDatabase(
                                          categorie.nameAr ?? "خالي",
                                          categorie.name ?? "Null"),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  Text(categorie.date!.split(' ')[0],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  Text("$count",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black))
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        bool isNeddDelete = false;
                                        await alertCheckPublic(
                                            title: "تنبية",
                                            middleText:
                                                "هل تريد حذف التصنيف للتاكيد اضغط نعم للالغاء اضغط لا",
                                            onPressedYes: () {
                                              isNeddDelete = true;
                                              Get.back();
                                            },
                                            onPressedNo: () {
                                              isNeddDelete = false;
                                              Get.back();
                                            });
                                        if (isNeddDelete) {
                                          await controller.deleteCategorie(
                                              categorie.id!, categorie.image);
                                        }
                                      },
                                      icon: const Icon(Icons.delete)),
                                  IconButton(
                                      onPressed: () {
                                        controller.goToEditCategorie(categorie);
                                      },
                                      icon: const Icon(Icons.edit)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            );
          },
        ),
      ),
    );
  }
}
