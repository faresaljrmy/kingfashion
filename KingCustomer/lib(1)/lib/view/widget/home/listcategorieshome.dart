import 'package:kingfashion/controller/home_controller.dart';
import 'package:kingfashion/core/constant/color.dart';
import 'package:kingfashion/core/functions/translatefatabase.dart';
import 'package:kingfashion/data/model/categoriesmodel.dart';
import 'package:kingfashion/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ListCategoriesHome extends GetView<HomeControllerImp> {
  const ListCategoriesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: controller.categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Categories(
            i: index,
            categoriesModel:
                CategoriesModel.fromJson(controller.categories[index]),
          );
        },
      ),
    );
  }
}

class Categories extends GetView<HomeControllerImp> {
  final CategoriesModel categoriesModel;
  final int? i;
  const Categories({Key? key, required this.categoriesModel, required this.i})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.goToItems(controller.categories, i!, categoriesModel.id!);
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColor.thirdColor,
                borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 70,
            width: 70,
            child:
                //    Image.asset(
                //   "assets/images/1.png",
                //   height: 100,
                //   width: 150,
                //   fit: BoxFit.fill,
                // ),
                (categoriesModel.image != null &&
                        categoriesModel.image != "empty")
                    ? SvgPicture.network(
                        "${AppLink.imagestCategories}/${categoriesModel.image}",
                        color: AppColor.secondColor)
                    : Container(),
          ),
          Text(
            "${translateDatabase(categoriesModel.nameAr, categoriesModel.name)}",
            style: const TextStyle(fontSize: 13, color: AppColor.black),
          )
        ],
      ),
    );
  }
}
