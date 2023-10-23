import 'package:adminkingfashion/controller/deliverys/view_controller.dart';
import 'package:adminkingfashion/core/class/handlingdataview.dart';
import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/core/shaerd/customlist_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliverysView extends StatelessWidget {
  const DeliverysView({super.key});

  @override
  Widget build(BuildContext context) {
    DeliverysViewController controller = Get.put(DeliverysViewController());
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoute.deliverysadd);
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(title: const Text("عمال التوصيل")),
        body: WillPopScope(
            onWillPop: () {
              return controller.myback();
            },
            child: GetBuilder<DeliverysViewController>(
              builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: ListView.builder(
                        itemCount: controller.data.length,
                        itemBuilder: (context, index) => Card(
                              child: CustomListTaile(
                                title: "${controller.data[index].deliveryName}",
                                subTitle:
                                    "${controller.data[index].deliveryEmail}",
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: AppColors.primaryColor,
                                  child: Text(
                                    "${controller.data[index].deliveryId}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                trealingicon: Icons.delete,
                                coloricon: AppColors.red,
                              ),
                            )),
                  )),
            )));
  }
}
