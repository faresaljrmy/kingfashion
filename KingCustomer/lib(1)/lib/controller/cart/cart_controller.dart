import 'package:kingfashion/core/class/statusrequest.dart';
import 'package:kingfashion/core/constant/routes.dart';
import 'package:kingfashion/core/functions/handingdatacontroller.dart';
import 'package:kingfashion/core/services/services.dart';
import 'package:kingfashion/data/datasource/remote/cart_data.dart';
import 'package:kingfashion/data/datasource/remote/items_data.dart';
import 'package:kingfashion/data/model/cartmodel.dart';
import 'package:kingfashion/data/model/couponmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/data/model/itemsmodel.dart';

class CartController extends GetxController {
  TextEditingController? controllercoupon;

  CartData cartData = CartData(Get.find());
  ItemsData testData = ItemsData(Get.find());
  int? discountcoupon = 0;

  String? couponname;

  String? couponid;

  late StatusRequest statusRequest;

  CouponModel? couponModel;

  MyServices myServices = Get.find();

  List<CartModel> data = [];

  double priceorders = 0.0;

  int totalcountitems = 0;

  add(String itemsid) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await cartData.addCart(
        myServices.sharedPreferences.getString("id")!, itemsid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.rawSnackbar(
            title: "اشعار",
            messageText: const Text("تم اضافة المنتج الى السلة "));
        // data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }

  goToPageCheckout() {
    if (data.isEmpty) return Get.snackbar("تنبيه", "السله فارغه");
    Get.toNamed(AppRoute.checkout, arguments: {
      "couponid": couponid ?? "0",
      "priceorder": priceorders.toString(),
      "discountcoupon": discountcoupon.toString()
    });
  }

  // getAllImages(String itemid) async {
  //   statusRequest = StatusRequest.loading;
  //   var response = await testData.getImagesItem(itemid);
  //   statusRequest = handlingData(response);
  //   if (StatusRequest.success == statusRequest) {
  //     // Start backend
  //     if (response['status'] == "success") {
  //       List responsedata = response['data'];
  //       List<String> listimg = [];
  //       // itemsModel.listImage = [];
  //       for (var value in responsedata) {
  //         listimg.add(value["itm_image"]);
  //       }
  //       return listimg;
  //       // data.addAll(response['data']);
  //     } else {
  //       statusRequest = StatusRequest.failure;
  //     }
  //     // End
  //   }
  // }

  goToPageProductDetails(int index) async {
    ItemsModel itemsModel = ItemsModel.fromCartModel(data[index]);
    if (itemsModel.listImage == null || itemsModel.listImage!.isEmpty) {
      itemsModel.listImage!.add(itemsModel.itemsImage!);
    } else {
      itemsModel.listImage = [];
      itemsModel.listImage!.add(itemsModel.itemsImage!);
    }
    await Get.toNamed(AppRoute.productdetails,
        arguments: {"itemsmodel": itemsModel});
  }

  getTotalPrice() {
    return (priceorders - priceorders * discountcoupon! / 100);
  }

  delete(String itemsid) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await cartData.deleteCart(
        myServices.sharedPreferences.getString("id")!, itemsid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.rawSnackbar(
            title: "اشعار",
            messageText: const Text("تم ازالة المنتج من السلة "));
        // data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }

  checkcoupon() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await cartData.checkCoupon(controllercoupon!.text);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Map<String, dynamic> datacoupon = response['data'];
        couponModel = CouponModel.fromJson(datacoupon);
        discountcoupon = int.parse(couponModel!.couponDiscount!);
        couponname = couponModel!.couponName;
        couponid = couponModel!.couponId;
      } else {
        // statusRequest = StatusRequest.failure;
        discountcoupon = 0;
        couponname = null;
        couponid = null;
        Get.snackbar("Warning", "Coupon Not Valid");
      }
      // End
    }
    update();
  }

  resetVarCart() {
    totalcountitems = 0;
    priceorders = 0.0;
    data.clear();
  }

  refreshPage() {
    resetVarCart();
    view();
  }

  view() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await cartData.viewCart(myServices.sharedPreferences.getString("id")!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        List dataresponse = response['datacart'];
        priceorders = double.parse(response['totalcart'].toString());
        // Map dataresponsecountprice = response['countprice'];
        data.clear();
        data.addAll(dataresponse.map((e) => CartModel.fromJson(e)));
        // totalcountitems = int.parse(dataresponsecountprice['totalcount']);
        // priceorders = double.parse(dataresponsecountprice['totalprice']);
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }

  @override
  void onInit() {
    controllercoupon = TextEditingController();
    view();
    super.onInit();
  }
}
