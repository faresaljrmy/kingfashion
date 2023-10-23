import 'package:adminkingfashion/controller/items/view_controller.dart';
import 'package:adminkingfashion/core/class/handlingdataview.dart';
import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/linkapi.dart';
import 'package:adminkingfashion/view/widget/items/carditems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemsView extends StatelessWidget {
  const ItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    ItemsViewController controller = Get.put(ItemsViewController());
    return Scaffold(
        appBar: AppBar(title: const Text("المنتجات")),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoute.itemsadd);
          },
          child: const Icon(Icons.add),
        ),
        body: WillPopScope(
          onWillPop: () {
            return controller.myback();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GetBuilder<ItemsViewController>(
                builder: ((controller) => HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: GridView.builder(
                      itemCount: controller.data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: ((context, index) => CardItemsView(
                          ondelete: () async {
                            await Get.defaultDialog(
                                title: "تنبية",
                                cancelTextColor: AppColors.thirdColor,
                                middleText: "هل تريد حذف المنتج",
                                buttonColor: AppColors.thirdColor,
                                onCancel: () {
                                  Get.back();
                                },
                                onConfirm: () async {
                                  controller.deleteItems(
                                      controller.data[index].id,
                                      controller.data[index].itemsImage);
                                  Get.back();
                                });
                          },
                          onedit: () {
                            controller.ogToeditItems(controller.data[index]);
                          },
                          onTap: () {},
                          imageurl:
                              "${AppLink.imagestItems}/${controller.data[index].itemsImage}",
                          title: "${controller.data[index].nameAr}",
                          date: "بتاريخ:${controller.data[index].itemsDate}")),
                    )))),
          ),
        ));
  }
}
