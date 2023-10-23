import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/admin/controller/admin/sizes/viewsize_controller.dart';
import 'package:kingfashion/core/class/handlingdataview.dart';
import 'package:kingfashion/core/functions/alertcheckpublic.dart';
import 'package:kingfashion/core/functions/translatefatabase.dart';
import 'package:kingfashion/data/model/sizemodel.dart';

class ViewAllSizesAdmin extends StatelessWidget {
  const ViewAllSizesAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    ViewSizesControllerImp controller = Get.put(ViewSizesControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sizes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.goToAddSize();
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: GetBuilder<ViewSizesControllerImp>(
          builder: (controller) {
            return HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Container(
                color: Colors.grey.shade200,
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: controller.listsiz.length,
                    itemBuilder: (context, index) {
                      SizeModel size = controller.listsiz[index];

                      return Container(
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 10),
                        height: 100,
                        width: double.infinity,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      translateDatabase(size.namear ?? "خالي",
                                          size.name ?? "Null"),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  Text(size.dateTime!.split(' ')[0],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
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
                                          await controller.deleteSize(size.id!);
                                        }
                                      },
                                      icon: const Icon(Icons.delete)),
                                  IconButton(
                                      onPressed: () {
                                        controller.goToEditSize(size);
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
