import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kingfashion/admin/controller/admin/items/viewitems_controller.dart';
import 'package:kingfashion/core/class/handlingdataview.dart';
import 'package:kingfashion/core/functions/alertcheckpublic.dart';
import 'package:kingfashion/core/functions/translatefatabase.dart';
import 'package:kingfashion/data/model/itemsmodel.dart';
import 'package:kingfashion/linkapi.dart';

class ViewAllItemsAdmin extends StatelessWidget {
  const ViewAllItemsAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    // ViewItemsControllerImp controller =
    Get.put(ViewItemsControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Items"),
      ),
      floatingActionButton:
          GetBuilder<ViewItemsControllerImp>(builder: (controller) {
        return FloatingActionButton(
          onPressed: () {
            controller.goToAddItem();
          },
          child: const Icon(Icons.add),
        );
      }),
      body: SafeArea(
        child: GetBuilder<ViewItemsControllerImp>(
          builder: (controller) {
            return HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Container(
                color: Colors.grey.shade200,
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: controller.listItem.length,
                    itemBuilder: (context, index) {
                      ItemsModel item = controller.listItem[index];

                      return Container(
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 10),
                        height: 100,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: item.image.toString().endsWith(".svg")
                                  ? SvgPicture.network(
                                      "${AppLink.imagestCategories}/${item.image}")
                                  : Image.network(
                                      "${AppLink.imagestCategories}/${item.image}"),
                              // SvgPicture.network(
                              //     "${AppLink.imagestCategories}/${item.image}",
                              //     color: AppColor.secondColor),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      translateDatabase(item.nameAr ?? "خالي",
                                          item.name ?? "Null"),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  Text(item.itemsDate!.split(' ')[0],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
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
                                          await controller.deleteItem(
                                              item.id!, item.image);
                                        }
                                      },
                                      icon: const Icon(Icons.delete)),
                                  IconButton(
                                      onPressed: () {
                                        controller.goToEditItem(item);
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
