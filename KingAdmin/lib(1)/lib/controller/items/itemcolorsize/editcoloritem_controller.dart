// ignore_for_file: use_build_context_synchronously

import 'package:adminkingfashion/controller/items/edit_controller.dart';
import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/funcations/alertcheckpublic.dart';
import 'package:adminkingfashion/core/funcations/handlinfdatacontroller.dart';
import 'package:adminkingfashion/core/funcations/sizedialogs.dart';
import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:adminkingfashion/core/localization/changelocallangcontroller.dart';
import 'package:adminkingfashion/core/services/services.dart';
import 'package:adminkingfashion/data/datasource/remote/color_data.dart';
import 'package:adminkingfashion/data/datasource/remote/itemcolorsize.dart';
import 'package:adminkingfashion/data/datasource/remote/size_data.dart';
import 'package:adminkingfashion/data/model/colormodel.dart';
import 'package:adminkingfashion/data/model/itemsmodel.dart';
import 'package:adminkingfashion/data/model/sizemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemsEditColorController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusReqAddSize = StatusRequest.none;
  StatusRequest statusReqDeleteColor = StatusRequest.none;
  StatusRequest statusReqDeleteSize = StatusRequest.none;

  MyServices myServices = Get.find();
  // late GlobalKey<FormState> formstate;
  ItemColorSizeDataRemote itemsDataRemote = ItemColorSizeDataRemote(Get.find());
  late TextEditingController count;
  late TextEditingController price;
  late TextEditingController descount;

  /// colors
  List<ColorModel> listColors = [];
  List<ColorModel> selectedListColors = [];
  ColorsData colorsData = ColorsData(Get.find());
  // String? strSelectedColor;
  ColorModel selectedColor = ColorModel();
  // String strSelColorID = "";
  dynamic itemid;
  dynamic userid;
  ItemsModel? itemsModel;

  ///  Sizes
  List<SizeModel> listSize = [];
  SizesData sizesData = SizesData(Get.find());
  SizeDialogs sizeDialogs = SizeDialogs();

  @override
  void onInit() async {
    itemsModel = Get.arguments["itemsModel"];
    itemid = itemsModel!.id;
    selectedListColors = itemsModel!.colors ?? [];
    count = TextEditingController();
    price = TextEditingController();
    descount = TextEditingController();
    localeController = Get.put(LocaleController());
    getdataColors();
    getdataSizes();
    super.onInit();
  }

  @override
  void dispose() {
    count.dispose();
    price.dispose();
    descount.dispose();

    super.dispose();
  }

  late LocaleController localeController;
  changeSelectedColor(String value) {
    if (myServices.sharedPreferences.getString("lang") == "ar") {
      selectedColor = listColors
          .where(
            (element) => element.nameAr.toString() == value,
          )
          .first;
    } else {
      selectedColor = listColors
          .where(
            (element) => element.name.toString() == value,
          )
          .first;
    }

    update();
  }

  addColor() {
    if (selectedColor.id != null) {
      if (selectedListColors.isEmpty) {
        selectedListColors.add(selectedColor);
      } else {
        int count = selectedListColors
            .where((element) => element.id == selectedColor.id)
            .length;
        if (count > 0) {
          Get.snackbar(
            translateDatabase("موجود", "Exists"),
            translateDatabase("اللون مضاف", "Color is added"),
          );
        } else {
          selectedListColors.add(selectedColor);
        }
      }
    }
    update();
  }

  getdataColors() async {
    var response = await colorsData.getColors();
    // print("================================= Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List responsedata = response['data'];
        listColors.addAll(responsedata.map((e) => ColorModel.fromJson(e)));
      } else {}
    }

    update();
  }

  removeColorFromSelected(String colorid) async {
    update();
  }

  removeSizeFromSelected(int indexcolor, int indexsize) {
    selectedListColors[indexcolor].sizes!.removeAt(indexsize);
    update();
  }

  getdataSizes() async {
    update();
    var response = await sizesData.getSizes();
    // print("================================= Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List responsedata = response['data'];
        listSize.addAll(responsedata.map((e) => SizeModel.fromJson(e)));
      } else {}
    }

    update();
  }

  addSize(BuildContext context, int index) async {
    sizeDialogs = SizeDialogs(
      allSizes: listSize,
      context: context,
      langCode: myServices.sharedPreferences.getString("lang"),
    );
    if (selectedListColors[index].sizes == null) {
      selectedListColors[index].sizes = [];
    }

    SizeModel size = await sizeDialogs.addSize();

    if (size.id != null) {
      ColorModel col = selectedListColors[index];

      Map dataColorSize = {
        "itmid": itemid,
        "clrid": col.id,
        "sizeid": size.id,
        "qty": size.qty,
        "price": size.price,
        "descount": size.descount,
        "userid": userid,
      };
      var responseColor = await itemsDataRemote.addDataSize(dataColorSize);
      statusRequest = handlingData(responseColor);
      if (StatusRequest.success == statusRequest) {
        if (responseColor['status'] == "success") {
          size.itmclrsizid = responseColor['id'];
          selectedListColors[index].sizes!.add(size);

          print(
              "================================= DataColorSize $dataColorSize=============\n========\n=");
        } else {
          statusRequest = StatusRequest.failure;
        }
      }
    }

    update();
  }

  editSize(BuildContext context, SizeModel size, int indexcolor,
      int indexsize) async {
    sizeDialogs = SizeDialogs(
        allSizes: listSize,
        context: context,
        langCode: myServices.sharedPreferences.getString("lang"),
        sizeToEdit: size);
    if (selectedListColors[indexcolor].sizes == null) {
      selectedListColors[indexcolor].sizes = [];
    }

    size = await sizeDialogs.editSize();
    if (size.id != null) {
      ColorModel col = selectedListColors[indexcolor];

      Map dataColorSize = {
        "id": size.id,
        "itmid": itemid,
        "clrid": col.id,
        "sizeid": size.id,
        "qty": size.qty,
        "price": size.price,
        "descount": size.descount,
        "userid": userid,
      };
      var responseColor = await itemsDataRemote.editDataSize(dataColorSize);
      statusRequest = handlingData(responseColor);
      if (StatusRequest.success == statusReqAddSize) {
        if (responseColor['status'] == "success") {
          statusRequest = statusReqAddSize;
          selectedListColors[indexcolor].sizes![indexsize] = size;

          print(
              "================================= DataColorSize $dataColorSize=============\n========\n=");
        } else {
          statusRequest = StatusRequest.failure;
        }
      }
    }

    update();
  }

  save(BuildContext context) {
    if (itemid != null) {
      Get.back();
    } else {
      ItemsEditController iec = Get.find();
      // iac.selectedListColors
      List<ColorModel> listCol = [];
      for (int i = 0; i < selectedListColors.length; i++) {
        ColorModel color = selectedListColors[i];
        if (color.sizes != null) {
          if (color.sizes!.isNotEmpty) {
            listCol.add(color);
          }
        }
      }
      iec.getColors(listCol);
      Get.back();
    }
  }

  deleteColor(BuildContext context, ColorModel color) async {
    bool isNeededDelete = false;
    await alertCheckPublic(
        title: "تنبية",
        middleText: "هل تريد حذف اللون للتاكيد اضغط نعم للالغاء اضغط لا",
        onPressedYes: () {
          isNeededDelete = true;
          Get.back();
        },
        onPressedNo: () {
          isNeededDelete = false;
          Get.back();
        });
    if (isNeededDelete) {
      if (color.sizes != null) {
        if (color.sizes!.isNotEmpty) {
          statusReqDeleteColor = StatusRequest.loading;
          update();

          Map dataColorSize = {
            "itmid": itemid,
            "clrid": color.id,
            "userid": userid,
          };
          var responseColor =
              await itemsDataRemote.deleteDataAllSizeInColor(dataColorSize);
          statusReqDeleteColor = handlingData(responseColor);
          if (StatusRequest.success == statusReqAddSize) {
            if (responseColor['status'] == "success") {
              removeColorFromSelected(color.id.toString());
            } else {
              statusReqDeleteColor = StatusRequest.failure;
            }
          }
        } else {
          removeColorFromSelected(color.id.toString());
        }
      } else {
        removeColorFromSelected(color.id.toString());
      }
    }
    update();
  }

  deleteSize(BuildContext context, int indexcolor, int indexsize) async {
    ColorModel color = selectedListColors[indexcolor - 1];

    bool isNeededDelete = false;
    await alertCheckPublic(
        title: "تنبية",
        middleText: "هل تريد حذف المقاس للتاكيد اضغط نعم للالغاء اضغط لا",
        onPressedYes: () {
          isNeededDelete = true;
          Get.back();
        },
        onPressedNo: () {
          isNeededDelete = false;
          Get.back();
        });
    if (isNeededDelete) {
      statusReqDeleteSize = StatusRequest.loading;
      update();

      Map dataColorSize = {
        "itmid": itemid,
        "sizeid": color.sizes![indexsize].id,
        "clrid": color.id,
        "userid": userid,
      };
      var responseColor = await itemsDataRemote.deleteDataSize(dataColorSize);
      statusReqDeleteSize = handlingData(responseColor);
      if (StatusRequest.success == statusReqAddSize) {
        if (responseColor['status'] == "success") {
          removeSizeFromSelected(indexcolor - 1, indexsize);
        } else {
          statusReqDeleteSize = StatusRequest.failure;
        }
      }
    }
    update();
  }
}
