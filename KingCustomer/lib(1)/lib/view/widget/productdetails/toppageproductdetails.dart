import 'package:cached_network_image/cached_network_image.dart';
import 'package:kingfashion/core/constant/color.dart';
import 'package:kingfashion/data/model/itemsmodel.dart';
import 'package:kingfashion/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopProductPageDetails extends StatelessWidget {
  final ItemsModel itemsModel;
  final String tag;
  const TopProductPageDetails(
      {Key? key, required this.itemsModel, required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 180,
          decoration: const BoxDecoration(color: AppColor.secondColor),
        ),
        Positioned(
            top: 30.0,
            right: Get.width / 8,
            left: Get.width / 8,
            child: Hero(
                tag: "${itemsModel.id} $tag",
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      itemsModel.listImage!.length,
                      (index) => CachedNetworkImage(
                        imageUrl:
                            "${AppLink.imagestItems}/${itemsModel.listImage![index]}",
                        height: 250,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                )
                // : CachedNetworkImage(
                //     imageUrl:
                //         "${AppLink.imagestItems}/${controller.itemsModel.itemsImage!}",
                //     height: 250,
                //     fit: BoxFit.fill,
                //   ),
                ))
      ],
    );
  }
}
