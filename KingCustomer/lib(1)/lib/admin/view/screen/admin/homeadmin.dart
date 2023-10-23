import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/admin/controller/admin/homeadmin_controller.dart';
import 'package:kingfashion/core/alertsignout.dart';
import 'package:kingfashion/core/class/handlingdataview.dart';
import 'package:kingfashion/core/localization/changelocal.dart';
import 'package:kingfashion/core/shared/custombutton.dart';
import 'package:kingfashion/admin/view/widget/admin/homeadmin/custombuttonhomeadmin.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    HomeAdminControllerImp controller = Get.put(HomeAdminControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: TextButton(
            onPressed: () async {
              LocaleController localeController = Get.put(LocaleController());
              await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Change Language"),
                      actions: [
                        Column(
                          children: [
                            CustomButton(
                              text: "English",
                              onPressed: () async {
                                localeController.changeLang("en");
                                Navigator.pop(context);
                              },
                            ),
                            CustomButton(
                              text: "Arabic",
                              onPressed: () async {
                                localeController.changeLang("ar");
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        )
                      ],
                    );
                  });
            },
            child: Text(
              controller.lang ?? "Null",
              style: const TextStyle(color: Colors.black),
            )),
        title: Text("adminAppBar".tr),
        actions: [
          IconButton(
              onPressed: () async {
                await alertSignOut();
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: SafeArea(
        child: GetBuilder<HomeAdminControllerImp>(builder: (controller) {
          return HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButtonHomeAdmin(
                          color: Colors.amber,
                          onTap: () {
                            controller.goToCategories();
                          },
                          title: "adminCat".tr,
                          details: controller.listcategories.length.toString(),
                        ),
                        CustomButtonHomeAdmin(
                            color: Colors.red,
                            onTap: () {
                              controller.goToItems();
                            },
                            title: "adminItm".tr,
                            details: controller.listItems.length.toString()),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButtonHomeAdmin(
                            color: Colors.amber,
                            onTap: () {
                              controller.goToColors();
                            },
                            title: "adminClr".tr,
                            details: controller.listColors.length.toString()),
                        CustomButtonHomeAdmin(
                            color: Colors.red,
                            onTap: () {
                              controller.goToSizes();
                            },
                            title: "adminSiz".tr,
                            details: controller.listSizes.length.toString()),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButtonHomeAdmin(
                            color: Colors.amber,
                            onTap: () {
                              controller.goToCoupons();
                            },
                            title: "adminCup".tr,
                            details: controller.listCoupon.length.toString()),
                        CustomButtonHomeAdmin(
                            color: Colors.red,
                            onTap: () {
                              controller.goToUsers();
                            },
                            title: "adminUsr".tr,
                            details: controller.listUsers.length.toString()),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButtonHomeAdmin(
                            color: Colors.amber,
                            onTap: () {
                              controller.goToOrders();
                            },
                            title: "adminOrd".tr,
                            details: controller.listOrders.length.toString()),
                        CustomButtonHomeAdmin(
                          color: Colors.red,
                          onTap: () {},
                          title: "adminCust".tr,
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        }),
      ),
    );
  }
}
