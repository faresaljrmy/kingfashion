import 'package:adminkingfashion/controller/orders/ordersscreen_controller.dart';
import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:adminkingfashion/core/constant/imgaeasset.dart';
import 'package:adminkingfashion/view/widget/custombuttomappbar.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(OrderScreenControllerImp());
    return GetBuilder<OrderScreenControllerImp>(
        builder: ((controller) => Scaffold(
            bottomNavigationBar: const CustomButtomAppBar(),
            appBar: AppBar(
              title: const Text("الطلبات"),
            ),
            drawer: Drawer(
              backgroundColor: AppColors.backgroundcolor,
              child: Column(
                children: [
                  Container(
                    height: 150,
                    color: AppColors.thirdColor,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                            top: Get.width / 5,
                            left: Get.width / 2.0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 120,
                                  width: 120,
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(160)),
                                  child: CircleAvatar(
                                    radius: 70,
                                    backgroundColor: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Image.asset(
                                        AppImageAsset.avatar,
                                        height: 75,
                                        width: 70,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "${controller.myServices.sharedPreferences.getString("deliveryname")}",
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                // const SizedBox(height:2,),
                                Text(
                                  " +967 ${controller.myServices.sharedPreferences.getString("phone")}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            body: controller.listpage.elementAt(controller.currntpage))));
  }
}
