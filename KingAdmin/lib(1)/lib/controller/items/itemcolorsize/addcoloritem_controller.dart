import 'package:adminkingfashion/controller/items/add_controller.dart';
import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/funcations/alertcheckpublic.dart';
import 'package:adminkingfashion/core/funcations/handlinfdatacontroller.dart';
import 'package:adminkingfashion/core/funcations/sizedialogs.dart';
import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:adminkingfashion/core/services/services.dart';
import 'package:adminkingfashion/data/datasource/remote/color_data.dart';
import 'package:adminkingfashion/data/datasource/remote/itemcolorsize.dart';
import 'package:adminkingfashion/data/datasource/remote/size_data.dart';
import 'package:adminkingfashion/data/model/colormodel.dart';
import 'package:adminkingfashion/data/model/itemsmodel.dart';
import 'package:adminkingfashion/data/model/sizemodel.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class ItemsAddColorController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  // StatusRequest statusReqAddSize = StatusRequest.none;
  // StatusRequest statusReqDeleteColor = StatusRequest.none;
  // StatusRequest statusReqDeleteSize = StatusRequest.none;

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
  ItemsModel? itemsModel;
  dynamic itemid;
  dynamic userid;
  String? langCode;
  String? operation;

  ///  Sizes
  List<SizeModel> listSize = [];
  SizesData sizesData = SizesData(Get.find());
  SizeDialogs sizeDialogs = SizeDialogs();

  @override
  void onInit() async {
    itemsModel = Get.arguments["itemsModel"];
    if (itemsModel != null) {
      itemid = itemsModel!.id;
      selectedListColors = itemsModel!.colors ?? [];
      operation = "edit";
    } else {
      operation = "add";
    }

    print(
        "ItemsAddColorController======================$itemid=======================");
    userid = myServices.sharedPreferences.getString("id");
    langCode = myServices.sharedPreferences.getString("lang");
    count = TextEditingController();
    price = TextEditingController();
    descount = TextEditingController();

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

  changeSelectedColor(String value) {
    if (langCode == "ar") {
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
    SmartDialog.showLoading();
    if (selectedColor.id != null) {
      if (selectedListColors.isEmpty) {
        selectedListColors.add(selectedColor);
      } else {
        int count = selectedListColors
            .where((element) => element.id == selectedColor.id)
            .length;
        if (count > 0) {
          return Get.rawSnackbar(
                  message: translateDatabase("اللون مضاف", "Color is added"),
                  title: translateDatabase("موجود", "Exists"))
              .show();
        } else {
          selectedListColors.add(selectedColor);
        }
      }
    }
    SmartDialog.dismiss();
    update();
  }

  getdataColors() async {
    var response = await colorsData.getColors();
    print("================================= Controller $response");
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
    selectedListColors
        .removeWhere((element) => element.id.toString() == colorid);
    update();
  }

  removeSizeFromSelected(int indexcolor, int indexsize) {
    selectedListColors[indexcolor].sizes!.removeAt(indexsize);
    update();
  }

  getdataSizes() async {
    update();
    var response = await sizesData.getSizes();
    print("================================= Controller $response");
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
    ColorModel color = selectedListColors[index];

    List<SizeModel> allSize = [];
    if (color.sizes != null && color.sizes!.isNotEmpty) {
      for (int i = 0; i < listSize.length; i++) {
        var size1 = listSize[i];
        var take = true;
        for (int j = 0; j < color.sizes!.length; j++) {
          var size2 = color.sizes![j];
          if (size1.id.toString() == size2.id.toString()) {
            take = false;
          }
        }
        if (take) {
          allSize.add(size1);
        }
      }
    } else {
      allSize = listSize;
    }
    // print("allSize=================${allSize.length}==========");
    sizeDialogs = SizeDialogs(
      allSizes: allSize,
      context: context,
      langCode: langCode,
    );
    selectedListColors[index].sizes ??= [];

    SizeModel size = await sizeDialogs.addSize();
    SmartDialog.showLoading(msg: "addSize");

    if (size.id != null) {
      if (itemid == null) {
        ItemsAddController iac = Get.find();

        await iac.addData();
        itemid = iac.itemid;
        userid = iac.userid;
      }
      Map dataColorSize = {
        "itmid": itemid,
        "clrid": color.id,
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
          if (size.itmclrsizid != null) {
            size.itmclrsizid = responseColor['id'];
          }
          selectedListColors[index].sizes!.add(size);
        } else {
          // statusReqAddSize = StatusRequest.failure;
        }
      }
    }
    SmartDialog.dismiss();
    update();
  }

  editSize(BuildContext context, SizeModel size, int indexcolor,
      int indexsize) async {
    sizeDialogs = SizeDialogs(
        allSizes: listSize,
        context: context,
        langCode: langCode,
        sizeToEdit: size);
    if (selectedListColors[indexcolor].sizes == null) {
      selectedListColors[indexcolor].sizes = [];
    }

    SizeModel sizeEdit = await sizeDialogs.editSize();
    SmartDialog.showLoading();

    if (sizeEdit.id != null) {
      ColorModel col = selectedListColors[indexcolor];
      Map dataColorSize = {
        "id": sizeEdit.itmclrsizid,
        "itmid": itemid,
        "clrid": col.id,
        "sizeid": size.id,
        "qty": sizeEdit.qty,
        "price": sizeEdit.price,
        "descount": sizeEdit.descount,
        "userid": userid,
      };
      print("editSize=====================$dataColorSize================");
      var responseColor = await itemsDataRemote.editDataSize(dataColorSize);
      statusRequest = handlingData(responseColor);
      if (StatusRequest.success == statusRequest) {
        if (responseColor['status'] == "success") {
          selectedListColors[indexcolor].sizes![indexsize] = sizeEdit;
        } else {
          statusRequest = StatusRequest.failure;
        }
      }
      SmartDialog.dismiss();
    }

    update();
  }

  save(BuildContext context) {
    if (itemid != null) {
      Get.back();
    } else {
      ItemsAddController iac = Get.find();
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
      iac.getColors(listCol);
      Get.back();
    }
  }

  deleteColor(BuildContext context, ColorModel color) async {
    bool isNeededDelete = false;
    isNeededDelete = await alertCheckPublic(
      title: "تنبية",
      middleText: "هل تريد حذف اللون للتاكيد اضغط نعم للالغاء اضغط لا",
    );

    if (isNeededDelete) {
      SmartDialog.showLoading();

      if (color.sizes != null && color.sizes!.isNotEmpty) {
        if (color.sizes!.isNotEmpty) {
          SmartDialog.dismiss();
          isNeededDelete = await alertCheckPublic(
              title: translateDatabase("تنبية", "Alert"),
              middleText: translateDatabase(
                  "اللون لدية مقاسات هل تريد حذف كل المقاسات في هئا اللون",
                  "The Color Has Sizes Do You Need Delete All Sizes In Color"));
          if (isNeededDelete) {
            SmartDialog.showLoading();

            Map dataColorSize = {
              "itmid": itemid,
              "clrid": color.id,
              "userid": userid,
            };
            var responseColor =
                await itemsDataRemote.deleteDataAllSizeInColor(dataColorSize);
            statusRequest = handlingData(responseColor);
            if (StatusRequest.success == statusRequest) {
              if (responseColor['status'] == "success") {
                removeColorFromSelected(color.id.toString());
              } else if (responseColor['message'] == "hasrefrences") {
                await alertCheckPublic(
                  title: "80".tr,
                  middleText: "81".tr,
                );
                statusRequest = StatusRequest.failure;
              } else {
                statusRequest = StatusRequest.failure;
              }
            }
          }
        }
      } else {
        removeColorFromSelected(color.id.toString());
      }
      SmartDialog.dismiss();
      update();
    }
  }

  deleteSize(BuildContext context, int indexcolor, int indexsize) async {
    ColorModel color = selectedListColors[indexcolor];

    bool isNeededDelete = false;
    isNeededDelete = await alertCheckPublic(
      title: "تنبية",
      middleText: "هل تريد حذف المقاس للتاكيد اضغط نعم للالغاء اضغط لا",
    );
    if (isNeededDelete) {
      SmartDialog.showLoading();
      if (color.sizes != null) {
        Map dataColorSize = {
          "itmid": itemid,
          "sizeid": color.sizes![indexsize].id,
          "clrid": color.id,
          "userid": userid,
        };
        var responseColor = await itemsDataRemote.deleteDataSize(dataColorSize);
        statusRequest = handlingData(responseColor);
        if (StatusRequest.success == statusRequest) {
          if (responseColor['status'] == "success") {
            removeSizeFromSelected(indexcolor - 1, indexsize);
          } else if (responseColor['message'] == "hasrefrences") {
            isNeededDelete = await alertCheckPublic(
              title: "80".tr,
              middleText: "81".tr,
            );
            statusRequest = StatusRequest.failure;
          } else {
            statusRequest = StatusRequest.failure;
          }
        }
      }
      SmartDialog.dismiss();
      update();
    }
  }
}
