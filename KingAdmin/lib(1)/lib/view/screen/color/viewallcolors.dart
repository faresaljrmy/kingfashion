import 'package:adminkingfashion/core/funcations/alertcheckpublic.dart';
import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adminkingfashion/controller/colors/viewcolor_controller.dart';
import 'package:adminkingfashion/core/class/handlingdataview.dart';
import 'package:adminkingfashion/data/model/colormodel.dart';

class ViewAllColorsAdmin extends StatelessWidget {
  const ViewAllColorsAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    ViewColorsControllerImp controller = Get.put(ViewColorsControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: Text(translateDatabase("الالوان", "Colors")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.goToAddColor();
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: GetBuilder<ViewColorsControllerImp>(
          builder: (controller) {
            return HandlingDataViewRequest(
              statusRequest: controller.statusRequest,
              widget: Container(
                color: Colors.grey.shade200,
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: controller.listclr.length,
                    itemBuilder: (context, index) {
                      ColorModel color = controller.listclr[index];

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
                                      translateDatabase(color.nameAr ?? "خالي",
                                          color.name ?? "Null"),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  Text(color.dateTime!.split(' ')[0],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  Container(
                                    height: 20,
                                    width: 20,
                                    color: color.rgb != null
                                        ? Color(int.parse(color.rgb ?? "ffffff",
                                            radix: 16))
                                        : Colors.red,
                                  )
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
                                                "هل تريد حذف اللون للتاكيد اضغط نعم للالغاء اضغط لا",
                                                "Do You Need Delete Color? for Confirm Click Yes For Cancel Click No "),
                                            onPressedYes: () {
                                              isNeddDelete = true;
                                              Get.back();
                                            },
                                            onPressedNo: () {
                                              isNeddDelete = false;
                                              Get.back();
                                            });

                                        if (isNeddDelete) {
                                          await controller
                                              .deleteColor(color.id!);
                                        }
                                      },
                                      icon: const Icon(Icons.delete)),
                                  IconButton(
                                      onPressed: () {
                                        controller.goToEditColor(color);
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
