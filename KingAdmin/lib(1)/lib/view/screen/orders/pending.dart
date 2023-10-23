import 'package:flutter/material.dart';
import 'package:adminkingfashion/controller/orders/pending_controller.dart';
import 'package:adminkingfashion/core/class/handlingdataview.dart';
import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:get/get.dart';
import 'package:adminkingfashion/view/widget/order/customcardpendingorder.dart';

class PendigOrdersPage extends StatelessWidget {
  const PendigOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PendingController());
    return Scaffold(
      // appBar: AppBar(
      //   title:const Text("Orders"), ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GetBuilder<PendingController>(
              builder: (controller) => HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: RefreshIndicator(
                      color: AppColors.thirdColor,
                      onRefresh: () async {
                        controller.data.clear();
                        await controller.refershOrders();
                      },
                      child: ListView.builder(
                          itemCount: controller.data.length,
                          itemBuilder: (context, index) => CardPendingOrdes(
                              listorders: controller.data[index])),
                    ),
                  ))),
    );
  }
}
