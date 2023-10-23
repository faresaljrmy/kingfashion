import 'package:flutter/material.dart';
import 'package:adminkingfashion/controller/orders/pending_controller.dart';
import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/data/model/ordersmodel.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class CardPendingOrdes extends GetView<PendingController> {
  final OrdersModel listorders;
  const CardPendingOrdes({
    Key? key,
    required this.listorders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "رقم الطلب: # ${listorders.ordersId}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  Jiffy.parse(listorders.ordesDate!).fromNow(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor),
                )
              ],
            ),
            const Divider(),
            Text(
                "نوع الطلب :${controller.printOrdertype(listorders.ordersType.toString())}"),
            Text("سعر الطلب  :${listorders.ordersPrice}\$"),
            Text("سعر التوصيل : ${listorders.ordersPricedelivery}\$"),
            Text(
                "طريقة الدفع: ${controller.printpaymentmethod(listorders.ordersPaymentmethod.toString())}"),
            Text(
                "حالة الطلب:${controller.printOrderStatus(listorders.ordersStatus.toString())}"),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("إجمالي السعر:  ${listorders.ordersTotleprice}\$",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor)),
                if (listorders.ordersStatus == 0)
                  MaterialButton(
                    onPressed: () {
                      controller.approveOrders(listorders.ordersId.toString(),
                          listorders.ordersUsersid.toString());
                    },
                    color: AppColors.thirdColor,
                    child: const Text("موافقة",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.cardColor)),
                  ),
                MaterialButton(
                  onPressed: () {
                    Get.toNamed(AppRoute.detalisorders, arguments: {
                      "orderslist": listorders,
                    });
                  },
                  color: AppColors.thirdColor,
                  child: const Text("بيانات اكثر",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.cardColor)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
