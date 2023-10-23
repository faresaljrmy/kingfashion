import 'dart:io';

import 'package:adminkingfashion/controller/items/view_controller.dart';
import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/core/funcations/handlinfdatacontroller.dart';
import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:adminkingfashion/core/funcations/uploadfiles.dart';
import 'package:adminkingfashion/core/services/services.dart';
import 'package:adminkingfashion/data/datasource/remote/categories_data.dart';
import 'package:adminkingfashion/data/datasource/remote/items_data.dart';
import 'package:adminkingfashion/data/model/categoriesmodel.dart';
import 'package:adminkingfashion/data/model/colormodel.dart';
import 'package:adminkingfashion/data/model/itemsmodel.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ItemsEditController extends GetxController {
  ItemsDataRemote itemsDataRemote = ItemsDataRemote(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  GlobalKey<FormState> formstateeditcate = GlobalKey<FormState>();
// List<CategoriesModel> data =[];
  List<SelectedListItem> dropdownlist = [];
  late TextEditingController name;
  late TextEditingController namear;

  late TextEditingController description;
  late TextEditingController descriptionAr;

  late TextEditingController count;
  late TextEditingController price;
  late TextEditingController discount;

  TextEditingController? cateid;
  TextEditingController? catename;

  String? active;
  MyServices myServices = Get.find();
  ItemsModel? itemsModel;
  File? file;

  dynamic itemid;
  dynamic userid;
  List<ColorModel> selectedListColors = [];

  choosActivted(val) {
    active = val;
    update();
  }

  choosOptionImage() {
    showbottomSheet(choosUploadCamera, choosUploadFile);
  }

  choosUploadCamera() async {
    file = await imageUplodadCamera();
    update();
  }

  choosUploadFile() async {
    file = await fileUpload();
    update();
  }

  editData() async {
    if (formstateeditcate.currentState!.validate()) {
      if (catename!.text == "") {
        return Get.snackbar("تنبية", "الرجاء اختيار القسم");
      }
      statusRequest = StatusRequest.loading;
      update();
      Map data = {
        "name": name.text,
        "namear": namear.text,
        "descr": description.text,
        "descrar": descriptionAr.text,
        "price": price.text,
        "descount": discount.text,
        "catid": cateid!.text,
        "active": active,
        "userid": myServices.sharedPreferences.getString("id"),
        "imageold": itemsModel!.itemsImage,
      };
      var response = await itemsDataRemote.editData(data, file);
      print("================================= Controller $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.snackbar("نجاح", "تم تعديل المنتج");
          ItemsViewController cv = Get.find();
          cv.getdata();
          Get.back();
        } else {
          statusRequest = StatusRequest.failure;
        }
      }

      update();
    }
  }

  getCategories() async {
    CategoriesDataRemote categoriesDataRemote =
        CategoriesDataRemote(Get.find());
    statusRequest = StatusRequest.loading;
    update();
    var response = await categoriesDataRemote.getData();
    // print("================================= Controller $response");
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        List<CategoriesModel> data = [];
        List responsedata = response['data'];
        data.addAll(responsedata.map((e) => CategoriesModel.fromJson(e)));
        for (int i = 0; i < data.length; i++) {
          dropdownlist.add(SelectedListItem(
              name: translateDatabase(data[i].nameAr!, data[i].name),
              value: data[i].id));
        }
      }
    }
    update();
  }

  @override
  void onInit() {
    itemsModel = Get.arguments["itemsModel"];
    selectedListColors = itemsModel!.colors ?? [];
    cateid = TextEditingController(text: itemsModel!.categoriesId!);
    catename = TextEditingController(
        text: translateDatabase(
            itemsModel!.categoriesNameAr!, itemsModel!.categoriesName!));
    getCategories();
    name = TextEditingController();
    namear = TextEditingController();
    description = TextEditingController();
    descriptionAr = TextEditingController();
    count = TextEditingController();
    price = TextEditingController();
    discount = TextEditingController();
    name.text = itemsModel!.name!;
    namear.text = itemsModel!.nameAr!;
    description.text = itemsModel!.descr!;
    descriptionAr.text = itemsModel!.descrAr!;
    count.text = itemsModel!.itemsCount ?? "0";
    // count.text = itemsModel!.itemsCount!;
    price.text = itemsModel!.itemsPrice!;
    discount.text = itemsModel!.itemsDiscount!;
    active = itemsModel!.itemsActive;
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    namear.dispose();
    super.dispose();
  }

  removeColorFromSelected(String colorid) {
    selectedListColors.removeWhere((e) => e.id.toString() == colorid);
    update();
  }

  goToEditItemColor() async {
    if (formstateeditcate.currentState!.validate()) {
      await Get.toNamed(AppRoute.itemsaddcolor,
          arguments: {"itemsModel": itemsModel});
      // ItemsViewController cv = Get.find();
      // cv.getdata();
      // Get.back();
    }
  }

  getColors(List<ColorModel> listcol) {
    selectedListColors = listcol;
    update();
  }
}
