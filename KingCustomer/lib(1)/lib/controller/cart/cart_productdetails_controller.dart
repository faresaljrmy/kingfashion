import 'package:kingfashion/core/class/statusrequest.dart';
import 'package:kingfashion/core/functions/handingdatacontroller.dart';
import 'package:kingfashion/core/services/services.dart';
import 'package:kingfashion/data/datasource/remote/productdetails_data.dart';
import 'package:kingfashion/data/model/cartmodel.dart';
import 'package:kingfashion/data/model/colormodel.dart';
import 'package:kingfashion/data/model/itemsmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/data/model/sizemodel.dart';

abstract class CartProductDetailsController extends GetxController {}

class CartProductDetailsControllerImp extends CartProductDetailsController {
  // CartController cartController = Get.put(CartController());

  late ItemsModel itemsModel;
  List<ColorModel> listColor = [];
  List<SizeModel> listSize = [];
  // List<ColorModel> newlistColor = [];
  // List<SizeModel> newlistSize = [];
  String? clrid;
  dynamic cartid;
  int? selectedClr;
  ProductDetailsData productDetailsData = ProductDetailsData(Get.find());

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  int countitems = 0;

  intialData() async {
    statusRequest = StatusRequest.loading;
    itemsModel = Get.arguments['itemsmodel'];
    cartid = Get.arguments["cartid"];
    await getColorsItems(itemsModel.id!);
    // checkSizesCartIsSelected();
    statusRequest = StatusRequest.success;
    update();
  }

  checkSizesCartIsSelected() {
    for (int i = 0; i < listColor.length; i++) {
      ColorModel color = listColor[i];
      for (int j = 0; j < itemsModel.colors!.length; j++) {
        ColorModel col = itemsModel.colors![j];
        if (color.id == col.id) {
          for (int x = 0; x < color.sizes!.length; x++) {
            SizeModel size = color.sizes![x];
            for (int y = 0; y < col.sizes!.length; y++) {
              SizeModel siz = col.sizes![y];
              if (size.id == siz.id) {
                listColor[i].sizes![x].qtycart = siz.qtycart;
              }
            }
          }
        }
      }
    }
  }

  getColorsItems(String itemsid) async {
    statusRequest = StatusRequest.loading;
    var response = await productDetailsData.getColorsItems(
        myServices.sharedPreferences.getString("id")!, itemsid);

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        if (response['data'] != null) {
          List list = response['data'];
          listColor.addAll(list.map((e) => ColorModel.fromJsonItem(e)));
        } else {
          listColor = [];
        }
        // data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
  }

  changeColor(val, catval) {
    if (selectedClr != val) {
      selectedClr = val;
      clrid = catval;
      listSize = listColor[val].sizes ?? [];
    } else {
      selectedClr = null;
      listSize = [];
    }

    update();
  }

  addItems(CartModel cartModel, int index) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await productDetailsData.addCart(cartModel);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        cartid = response['id'];
        listSize[index].qtycart = cartModel.sizeqty;

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

  deleteitems(CartModel cartModel, int index) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await productDetailsData.deleteCart(cartModel);
    // print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        listSize[index].qtycart = cartModel.sizeqty;

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

  add(SizeModel size, int index) {
    CartModel cartModel = CartModel(
        cartItemsid: itemsModel.id,
        clrid: clrid,
        descount: size.descount,
        sizeqty:
            size.qtycart != null ? int.parse(size.qtycart.toString()) + 1 : 1,
        sizeId: size.id,
        price: size.price,
        cartUsersid: myServices.sharedPreferences.getString("id")!,
        cartId: cartid);
    addItems(cartModel, index);
    // update();
  }

  remove(SizeModel size, int index) {
    if (size.qtycart != null && int.parse(size.qtycart.toString()) > 0) {
      CartModel cartModel = CartModel(
          cartItemsid: itemsModel.id,
          clrid: clrid,
          sizeId: size.id,
          sizeqty: int.parse(size.qtycart.toString()) - 1,
          cartUsersid: myServices.sharedPreferences.getString("id")!,
          cartId: cartid);
      deleteitems(cartModel, index);
      // update();
    }
  }

  @override
  void onInit() {
    intialData();
    super.onInit();
  }
}
