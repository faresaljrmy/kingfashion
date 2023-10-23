import 'package:adminkingfashion/controller/items/view_controller.dart';
import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:adminkingfashion/core/constant/imgaeasset.dart';
import 'package:adminkingfashion/data/model/itemsmodel.dart';
import 'package:adminkingfashion/linkapi.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class CustomListItems extends GetView<ItemsViewController> {
  final ItemsModel itemsModel;
  const CustomListItems({super.key, required this.itemsModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.toNamed(AppRoute.itemsdetails,arguments: {
        //   "itemsdetalis":itemsModel
        // });
      },
      child: Card(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: itemsModel.id!,
                    child: CachedNetworkImage(
                      imageUrl:
                          "${AppLink.imagestItems}/${itemsModel.itemsImage!}",
                      width: 150,
                      height: 70,
                      fit: BoxFit.fill,
                    ),
                  ),
                  // Text("${translationDatabase(itemsModel.itemsNameAr!, itemsModel.itemsName!)}",
                  // style:const TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                  //  Text("${itemsModel.categoriesName} ",
                  //  style:const TextStyle(color: AppColors.grey,fontSize: 10,),textAlign: TextAlign.center,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${"70".tr}3.5",
                        textAlign: TextAlign.start,
                      ),
                      Container(
                        height: 20,
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: [
                            ...List.generate(5, (context) {
                              return const Icon(
                                Icons.star,
                                size: 14,
                              );
                            })
                          ],
                        ),
                      ),
                    ],
                  ),
                  //  const SizedBox(height: 20,),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${itemsModel.itemsPrice}\$",
                        style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: "sans"),
                      ),
                    ],
                  )
                ],
              ),
            ),
            if (itemsModel.itemsDiscount != "0")
              Positioned(
                  child: Image.asset(
                AppImageAsset.saleOne,
                width: 40,
              ))
          ],
        ),
      ),
    );
  }
}
