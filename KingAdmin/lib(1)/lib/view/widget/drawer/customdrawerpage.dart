import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  final String? imageUrl;
  final String? userName;
  final String? userPhone;
  const CustomDrawer({super.key, this.imageUrl, this.userName, this.userPhone});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                    left: Get.width / 2.4,
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
                                imageUrl!,
                                height: 75,
                                width: 70,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "$userName",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "$userPhone",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
