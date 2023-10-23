import 'package:adminkingfashion/controller/dashboard_controller.dart';
import 'package:adminkingfashion/core/constant/imgaeasset.dart';
import 'package:adminkingfashion/core/constant/routes.dart';

import 'package:adminkingfashion/core/funcations/alertdilogeexit.dart';
import 'package:adminkingfashion/core/funcations/changelanguage.dart';
import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:adminkingfashion/view/widget/dashboard/card_dashboard.dart';
import 'package:adminkingfashion/view/widget/drawer/customdrawerpage.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  await showDialogChangeLanguage();
                },
                icon: const Icon(Icons.language))
          ],
          centerTitle: true,
          title: Text(translateDatabase("الواجهة الرئسية", "Home")),
        ),
        drawer: CustomDrawer(
          imageUrl: AppImageAsset.avatar,
          userName:
              controller.myServices.sharedPreferences.getString("username"),
          userPhone: controller.myServices.sharedPreferences.getString("phone"),
        ),
        body: WillPopScope(
          onWillPop: () {
            alertDialogExit();
            return Future.value(false);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView(
              children: [
                GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    children: [
                      CardDashboard(
                          onTap: () {
                            Get.toNamed(AppRoute.categoriesview);
                          },
                          url: AppImageAsset.categories,
                          title: translateDatabase("الاقسام", "Categoreis")),
                      CardDashboard(
                          onTap: () {
                            Get.toNamed(AppRoute.itemsview);
                          },
                          url: AppImageAsset.items,
                          title: translateDatabase("المنتجات", "Items")),
                      CardDashboard(
                          onTap: () {
                            Get.toNamed(AppRoute.usersview);
                          },
                          url: AppImageAsset.users,
                          title: translateDatabase("العملاء", "Customers")),
                      CardDashboard(
                          onTap: () {
                            Get.toNamed(AppRoute.orderscreen);
                          },
                          url: AppImageAsset.ordes,
                          title: translateDatabase("الطلبات", "Orders")),
                      CardDashboard(
                          onTap: () {},
                          url: AppImageAsset.message,
                          title: translateDatabase("الرسائل", "Messages")),
                      CardDashboard(
                          onTap: () {},
                          url: AppImageAsset.notification,
                          title:
                              translateDatabase("الاشعارات", "Notification")),
                      CardDashboard(
                          onTap: () {
                            Get.toNamed(AppRoute.colorspage);
                          },
                          url: AppImageAsset.colorImage1,
                          title: translateDatabase("الالوان", "Colors")),
                      CardDashboard(
                          onTap: () {
                            Get.toNamed(AppRoute.sizespage);
                          },
                          url: AppImageAsset.sizeImage1,
                          title: translateDatabase("المقاسات", "Sizes")),
                    ])
              ],
            ),
          ),
        ));
  }
}
