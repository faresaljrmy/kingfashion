// ignore_for_file: prefer_const_constructors
import 'package:kingfashion/controller/cart/cart_controller.dart';
import 'package:kingfashion/core/class/handlingdataview.dart';
import 'package:kingfashion/view/widget/cart/custom_bottom_navgationbar_cart.dart';
import 'package:kingfashion/view/widget/cart/customitemscartlist.dart';
import 'package:kingfashion/view/widget/cart/topcardcart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    return Scaffold(
        appBar: AppBar(
          title: Text("My Cart"),
        ),
        bottomNavigationBar: GetBuilder<CartController>(
            builder: (controller) => BottomNavgationBarCart(
                shipping: "0",
                // controllercoupon: controller.controllercoupon!,
                // onApplyCoupon: () {
                //   // controller.checkcoupon();
                // },
                price: "${controller.priceorders}",
                discount: "${controller.discountcoupon}%",
                totalprice: "${controller.getTotalPrice()}")),
        body: GetBuilder<CartController>(
            builder: ((controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: ListView(
                  children: [
                    SizedBox(height: 10),
                    TopCardCart(
                        message:
                            "You Have ${controller.data.length} Items in Your List"),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ...List.generate(
                            controller.data.length,
                            (index) => InkWell(
                              onTap: () {
                                controller.goToPageProductDetails(index);
                              },
                              child: CustomItemsCartList(
                                  onAdd: () async {
                                    // await cartController
                                    //     .add(cartController.data[index].itemsId!);
                                    // cartController.refreshPage();
                                  },
                                  onRemove: () async {
                                    // await cartController.delete(
                                    //     cartController.data[index].itemsId!);
                                    // cartController.refreshPage();
                                  },
                                  imagename:
                                      "${controller.data[index].itemsImage}",
                                  name: "${controller.data[index].itemsName}",
                                  price:
                                      "${controller.data[index].totalPrice} \$",
                                  count: "${controller.data[index].countSize}"),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )))));
  }
}
