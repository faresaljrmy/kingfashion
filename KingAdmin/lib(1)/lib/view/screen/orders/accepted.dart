import 'package:adminkingfashion/controller/orders/accepted_controller.dart';
import 'package:adminkingfashion/view/widget/order/customcardaccepted.dart';
import 'package:flutter/material.dart';
import 'package:adminkingfashion/core/class/handlingdataview.dart';
import 'package:get/get.dart';

class AcceptedOrdersPage extends StatelessWidget {
  const AcceptedOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AcceptedController());
    return Scaffold(
      // appBar: AppBar(
      //   title:const Text("Orders"), ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GetBuilder<AcceptedController>(
            builder: (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: ListView.builder(
                  itemCount: controller.data.length,
                  itemBuilder: (context, index) =>
                      CardAccceptedOrders(listorders: controller.data[index])),
            ),
          )),
    );
  }
}
