import 'package:adminkingfashion/controller/users/view_controller.dart';
import 'package:adminkingfashion/core/class/handlingdataview.dart';
import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:adminkingfashion/core/shaerd/customlist_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    UsersViewController controller = Get.put(UsersViewController());
    return Scaffold(
        appBar: AppBar(title: Text(translateDatabase("العملاء", "Customers"))),
        body: WillPopScope(
            onWillPop: () {
              return controller.myback();
            },
            child: GetBuilder<UsersViewController>(
              builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: ListView.builder(
                        itemCount: controller.data.length,
                        itemBuilder: (context, index) => Card(
                              child: CustomListTaile(
                                title: "${controller.data[index].name}",
                                subTitle: "${controller.data[index].email}",
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: AppColors.primaryColor,
                                  child: Text(
                                    "${controller.data[index].id}",
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
