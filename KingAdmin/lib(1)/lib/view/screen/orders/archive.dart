import 'package:flutter/material.dart';
import 'package:adminkingfashion/controller/orders/archive_controller.dart';
import 'package:adminkingfashion/core/class/handlingdataview.dart';
import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:get/get.dart';
import 'package:adminkingfashion/view/widget/order/customcardarchive.dart';

class ArchiveOrdersPage extends StatelessWidget {
  const ArchiveOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ArchiveController());
    return Scaffold(
      // appBar: AppBar(
      //   title:const Text("Orders Archive"),
      //   centerTitle: true, ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GetBuilder<ArchiveController>(
              builder: (controller) => RefreshIndicator(
                    color: AppColors.thirdColor,
                    onRefresh: () async {
                      controller.data.clear();
                      await controller.refershOrders();
                    },
                    child: HandlingDataView(
                      statusRequest: controller.statusRequest,
                      widget: ListView.builder(
                          itemCount: controller.data.length,
                          itemBuilder: (context, index) => CardArchiveOrders(
                              listorders: controller.data[index])),
                    ),
                  ))),
    );
  }
}
