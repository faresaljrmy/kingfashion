import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adminkingfashion/controller/sizes/viewsize_controller.dart';
import 'package:adminkingfashion/core/class/handlingdataview.dart';
import 'package:adminkingfashion/core/funcations/alertcheckpublic.dart';
import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:adminkingfashion/data/model/sizemodel.dart';

class ViewAllSizesAdmin extends StatelessWidget {
  const ViewAllSizesAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    ViewSizesControllerImp controller = Get.put(ViewSizesControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: Text(translateDatabase("المقاسات", "Sizes")),
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
            return HandlingDataViewRequest(
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
                                            title: translateDatabase(
                                                "تنبية", "Alert"),
                                            middleText: translateDatabase(
                                                "هل تريد حذف المقاس للتاكيد اضغط نعم للالغاء اضغط لا",
                                                "Do You Need Delete Size? for Confirm Click Yes For Cancel Click No "),
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
