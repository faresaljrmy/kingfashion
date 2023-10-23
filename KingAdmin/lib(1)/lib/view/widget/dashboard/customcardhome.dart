import 'package:adminkingfashion/controller/home/homepage_controller.dart';
import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class CustomCardHome extends StatelessWidget {
  final String title;
  final String body;
  const CustomCardHome({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageControllerImp());
    return GetBuilder<HomePageControllerImp>(
        builder: ((controller) => Container(
              margin: const EdgeInsets.only(top: 10),
              child: Stack(
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: 150,
                      decoration: BoxDecoration(
                          color: AppColors.sky,
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        title: Text(title,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white)),
                        subtitle: Text(body,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )),
                  Positioned(
                      top: -20,
                      left: controller.myServices.sharedPreferences
                                  .getString("lang") ==
                              "ar"
                          ? -20
                          : null,
                      right: controller.myServices.sharedPreferences
                                  .getString("lang") ==
                              "en"
                          ? -20
                          : null,
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                            color: AppColors.thirdColor,
                            borderRadius: BorderRadius.circular(160)),
                      ))
                ],
              ),
            )));
  }
}
