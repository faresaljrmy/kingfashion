import 'package:adminkingfashion/controller/orders/ordersscreen_controller.dart';
import 'package:adminkingfashion/view/widget/dashboard/custombuttonbutoomappbar.dart';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class CustomButtomAppBar extends StatelessWidget {
  const CustomButtomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderScreenControllerImp>(
      builder: ((controller) => BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ...List.generate(controller.listpage.length, (index) {
              int i = index > 2 ? index - 1 : index;
              return CustomButtonButomAppBar(
                textbutton: controller.titlebuttomappbar[i],
                iconbutton: controller.iconbuttomappbar[i],
                onPressed: () {
                  controller.changePage(i);
                },
                active: controller.currntpage == i ? true : false,
              );
            })
          ]))),
    );
  }
}
