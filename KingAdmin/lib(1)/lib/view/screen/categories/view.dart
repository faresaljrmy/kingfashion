import 'package:adminkingfashion/controller/categories/view_controller.dart';
import 'package:adminkingfashion/core/class/handlingdataview.dart';
import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:adminkingfashion/view/widget/categories/cardcategories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoresView extends StatelessWidget {
  const CategoresView({super.key});

  @override
  Widget build(BuildContext context) {
    CategoresViewController controller = Get.put(CategoresViewController());
    return Scaffold(
        appBar: AppBar(title: Text(translateDatabase("الاقسام", "Categories"))),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoute.categoriesadd);
          },
          child: const Icon(Icons.add),
        ),
        body: WillPopScope(
          onWillPop: () {
            return controller.myback();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GetBuilder<CategoresViewController>(
                builder: ((controller) => HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: GridView.builder(
                      itemCount: controller.data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: ((context, index) => CardCategoriesView(
                          ondelete: () {
                            Get.defaultDialog(
                                title: translateDatabase("تنبية", "Alert"),
                                middleText: translateDatabase(
                                    "هل تريد حذف القسم",
                                    "Do You Need Delete Categorie"),
                                buttonColor: AppColors.thirdColor,
                                onCancel: () {},
                                onConfirm: () {
                                  controller.deleteCategoriy(
                                      controller.data[index].id,
                                      controller.data[index].image);
                                  Get.back();
                                });
                          },
                          onedit: () {
                            controller.ogToeditCategory(controller.data[index]);
                          },
                          onTap: () {},
                          url: "${controller.data[index].image}",
                          title:
                              "${translateDatabase(controller.data[index].nameAr, controller.data[index].name)}",
                          date: "بتاريخ:${controller.data[index].date}")),
                    )))),
          ),
        ));
  }
}
