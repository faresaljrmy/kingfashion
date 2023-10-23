import 'package:kingfashion/controller/cart/cart_productdetails_controller.dart';
import 'package:kingfashion/core/class/statusrequest.dart';
import 'package:kingfashion/core/constant/color.dart';
import 'package:kingfashion/core/constant/routes.dart';
import 'package:kingfashion/core/functions/translatefatabase.dart';
import 'package:kingfashion/data/model/colormodel.dart';
import 'package:kingfashion/data/model/sizemodel.dart';
import 'package:kingfashion/view/widget/productdetails/priceandcount.dart';
import 'package:kingfashion/view/widget/productdetails/toppageproductdetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProductDetails extends StatelessWidget {
  const CartProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CartProductDetailsControllerImp());

    return Scaffold(
      body: GetBuilder<CartProductDetailsControllerImp>(
          builder: (controller) => Stack(
                children: [
                  ListView(children: [
                    TopProductPageDetails(
                      itemsModel: controller.itemsModel,
                      tag: "cartProduct",
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${controller.itemsModel.name}",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                      color: AppColor.fourthColor,
                                    )),
                            const SizedBox(height: 10),
                            const SizedBox(height: 10),
                            Text(
                                "${translateDatabase(controller.itemsModel.descrAr, controller.itemsModel.descr)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: AppColor.grey2)),
                            const SizedBox(height: 10),
                            Container(
                              color: Colors.grey.shade400,
                              height: 50,
                              child: controller.listColor.isNotEmpty
                                  ? ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(width: 10),
                                      itemCount: controller.listColor.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return CartColorsDetails(
                                          i: index,
                                          colorModel:
                                              controller.listColor[index],
                                        );
                                      },
                                    )
                                  : const Text("Not Found Color"),
                            ),
                            SizedBox(
                              height: controller.listSize.length * 110,
                              child: controller.listSize.isNotEmpty
                                  ? ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: controller.listSize.length,
                                      itemBuilder: (context, index) {
                                        SizeModel size =
                                            controller.listSize[index];
                                        return PriceAndCountItems(
                                            size: size,
                                            onAdd: () {
                                              controller.add(size, index);
                                            },
                                            onRemove: () {
                                              controller.remove(size, index);
                                            },
                                            // price:
                                            //     "${controller.itemsModel.itemsPriceDiscount}",
                                            count: "${controller.countitems}");
                                      })
                                  : const Center(
                                      child: Text("Not Found Sizes"),
                                    ),
                            )
                          ]),
                    ),
                  ]),
                  controller.statusRequest == StatusRequest.loading
                      ? Container(
                          color: Colors.black.withOpacity(0.5),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Container(),
                ],
              )),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 40,
          child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: AppColor.secondColor,
              onPressed: () {
                Get.toNamed(AppRoute.cart);
              },
              child: const Text(
                "Go To Cart",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
    );
  }
}

class CartColorsDetails extends StatelessWidget {
  final ColorModel colorModel;
  final int? i;
  const CartColorsDetails({Key? key, required this.colorModel, required this.i})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CartProductDetailsControllerImp());
    return Column(
      children: [
        GetBuilder<CartProductDetailsControllerImp>(
          builder: (controller) => InkWell(
            onTap: () {
              controller.changeColor(i!, colorModel.id!);
            },
            child: Container(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 5),
              decoration: controller.selectedClr == i
                  ? BoxDecoration(
                      color: Color(
                          int.parse(colorModel.rgb ?? "00000000", radix: 16)),
                      border: Border(
                          bottom: BorderSide(
                              width: 3,
                              color: Color(int.parse(
                                  colorModel.rgb != "ffffffff"
                                      ? colorModel.rgb ?? "00000000"
                                      : "ff555555",
                                  radix: 16))
                              /*AppColor.primaryColor*/
                              )))
                  : null,
              child: Text(
                "${translateDatabase(colorModel.nameAr, colorModel.name)}",
                style: TextStyle(
                    fontSize: 20,
                    color: (colorModel.rgb != "ffffffff" &&
                            controller.selectedClr == i)
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
