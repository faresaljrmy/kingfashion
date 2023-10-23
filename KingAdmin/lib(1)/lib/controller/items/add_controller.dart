import 'dart:io';
import 'package:adminkingfashion/controller/items/view_controller.dart';
import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/core/funcations/handlinfdatacontroller.dart';
import 'package:adminkingfashion/core/funcations/uploadfiles.dart';
import 'package:adminkingfashion/core/services/services.dart';
import 'package:adminkingfashion/data/datasource/remote/categories_data.dart';
import 'package:adminkingfashion/data/datasource/remote/items_data.dart';
import 'package:adminkingfashion/data/model/categoriesmodel.dart';
import 'package:adminkingfashion/data/model/colormodel.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemsAddController extends GetxController {
  ItemsDataRemote itemsDataRemote = ItemsDataRemote(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  GlobalKey<FormState> formstateaddcate = GlobalKey<FormState>();
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

  File? file;

  /// colors
  // List<ColorModel> listColors = [];
  List<ColorModel> selectedListColors = [];
  // ColorsData colorsData = ColorsData(Get.find());
  // ColorDialogs colorDialogs = ColorDialogs();

  ///  Sizes
  // List<SizeModel> listSize = [];
  // SizesData sizesData = SizesData(Get.find());
  // SizeDialogs sizeDialogs = SizeDialogs();

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

  dynamic itemid;
  dynamic userid;
  addData() async {
    if (formstateaddcate.currentState!.validate()) {
      // if (file == null) {
      //   return Get.snackbar("تنبية", "الرجاء اختيار ايقونةالقسم");
      // }
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
        "userid": myServices.sharedPreferences.getString("id"),
      };
      var response = await itemsDataRemote.addData(data, file!);
      // print("================================= Controller $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          itemid = response['id'];
          userid = myServices.sharedPreferences.getString("id");
          // if (itemid != null) {
          //   int countAdd = 0;
          //   for (int i = 0; i < selectedListColors.length; i++) {
          //     ColorModel col = selectedListColors[i];
          //     if (col.sizes != null) {
          //       for (int j = 0; j < col.sizes!.length; j++) {
          //         SizeModel siz = col.sizes![j];
          //         Map dataColorSize = {
          //           "itmid": itemid,
          //           "clrid": col.id,
          //           "sizeid": siz.id,
          //           "qty": siz.qty,
          //           "price": siz.price,
          //           "descount": siz.descount,
          //           "userid": userid,
          //         };
          //         var responseColor =
          //             await itemsDataRemote.addItemColorSize(dataColorSize);
          //         // print(
          //         //     "====size$countAdd============================= ControllerresponseColor $responseColor==============");
          //         statusRequest = handlingData(responseColor);
          //         if (StatusRequest.success == statusRequest) {
          //           if (responseColor['status'] == "success") {
          //             print(
          //                 "================================= DataColorSize $dataColorSize=============\n========\n=");
          //             countAdd++;
          //           }
          //         }
          //       }
          //     }
          //   }
          //   Get.snackbar("نجاح", "تم إضافة المنتج و $countAdd من المقاسات");
          //   Get.offNamed(AppRoute.itemsview);
          //   ItemsViewController cv = Get.find();
          //   cv.getdata();
          // } else {
          //   Get.snackbar("خطأ", "حصل خطأ في الاضافة");
          // }
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
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        List<CategoriesModel> data = [];
        List responsedata = response['data'];
        data.addAll(responsedata.map((e) => CategoriesModel.fromJson(e)));
        for (int i = 0; i < data.length; i++) {
          dropdownlist
              .add(SelectedListItem(name: data[i].nameAr!, value: data[i].id));
        }
      }
    }
    update();
  }

  @override
  void onInit() async {
    getCategories();
    name = TextEditingController();
    namear = TextEditingController();
    description = TextEditingController();
    descriptionAr = TextEditingController();
    count = TextEditingController();
    price = TextEditingController();
    discount = TextEditingController();
    cateid = TextEditingController();
    catename = TextEditingController();
    // getdataColors();
    // getdataSizes();
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

  goToAddItemColor() async {
    if (formstateaddcate.currentState!.validate()) {
      await Get.toNamed(AppRoute.itemsaddcolor);
      if (itemid != null) {
        // Get.snackbar("نجاح", "تم إضافة المنتج");
        ItemsViewController cv = Get.find();
        cv.getdata();
        Get.back(closeOverlays: true);
      }
    }
  }

  getColors(List<ColorModel> listcol) {
    selectedListColors = listcol;
    update();
  }

  // getdataColors() async {
  //   var response = await colorsData.getColors();
  //   print("================================= Controller $response");
  //   statusRequest = handlingData(response);
  //   if (StatusRequest.success == statusRequest) {
  //     if (response['status'] == "success") {
  //       List responsedata = response['data'];
  //       listColors.addAll(responsedata.map((e) => ColorModel.fromJson(e)));
  //     } else {
  //       Get.showSnackbar(const GetSnackBar(
  //         title: "لايوجد الوان",
  //       ));
  //     }
  //   }
  //   update();
  // }
  // choosColors(BuildContext context) async {
  //   // selectedListColors.clear();
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       List<ColorModel> listselColor = listColors;
  //       List<ColorModel> selColor = [];
  //       for (int i = 0; i < selectedListColors.length; i++) {
  //         listselColor
  //             .removeWhere((element) => element.id == selectedListColors[i].id);
  //       }
  //       List<bool> listval =
  //           List.generate(listselColor.length, (index) => false);
  //       return AlertDialog(
  //         content: StatefulBuilder(
  //             builder: (BuildContext context, StateSetter setState) {
  //           return Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: List.generate(listselColor.length + 1, (int index) {
  //                 if (index < listselColor.length) {
  //                   ColorModel colorModel = listselColor[index];
  //                   return CheckboxListTile(
  //                     title: Text(colorModel.name ?? "null"),
  //                     subtitle: Text(colorModel.rgb ?? "null"),
  //                     value: listval[index],
  //                     onChanged: (value) {
  //                       if (value!) {
  //                         selColor.add(colorModel);
  //                       } else {
  //                         selColor.removeWhere(
  //                             (element) => element.id == colorModel.id);
  //                       }
  //                       setState(() => listval[index] = value);
  //                     },
  //                   );
  //                 } else {
  //                   return Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       CustomButton(
  //                           textbutton: "SELECT",
  //                           onPressed: () {
  //                             selectedListColors.addAll(selColor);
  //                             print(
  //                                 "selectedListColors=================${selectedListColors.map((e) => e.name)}====================");
  //                             Get.back();
  //                           })
  //                     ],
  //                   );
  //                 }
  //               }));
  //         }),
  //       );
  //     },
  //   );
  //   update();
  // }
  // choosSizes(BuildContext context, int indexColor) async {
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // List<SizeModel> selectedSize = [];
  //       List<SizeModel> sizes = listSize;
  //       List<bool> listval = List.generate(sizes.length, (index) => false);
  //       return AlertDialog(
  //         content: StatefulBuilder(
  //             builder: (BuildContext context, StateSetter setState) {
  //           return Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: List.generate(sizes.length + 1, (int index) {
  //                 if (index < sizes.length) {
  //                   SizeModel sizeModel = sizes[index];
  //                   if (sizeModel.qty == null ||
  //                       sizeModel.qty.toString().isEmpty) {
  //                     sizeModel.qty = 0;
  //                   }
  //                   return ListTile(
  //                     trailing: Checkbox(
  //                       value: listval[index],
  //                       onChanged: (value) {
  //                         if (value!) {
  //                           sizes[index].qty = 1;
  //                         } else {
  //                           sizes[index].qty = 0;
  //                           // selectedSize.removeWhere(
  //                           //     (element) => element.id == sizeModel.id);
  //                         }
  //                         setState(() => listval[index] = value);
  //                       },
  //                     ),
  //                     title: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(sizeModel.symbol ?? "null"),
  //                         Text(sizeModel.name ?? "null"),
  //                       ],
  //                     ),
  //                     subtitle: Row(
  //                       children: [
  //                         IconButton(
  //                             onPressed: () {
  //                               setState(() {
  //                                 sizeModel.qty++;
  //                                 listval[index] = true;
  //                               });
  //                             },
  //                             icon: const Icon(Icons.add)),
  //                         Text(sizeModel.qty.toString()),
  //                         IconButton(
  //                             onPressed: () {
  //                               setState(() {
  //                                 if (sizeModel.qty > 0) {
  //                                   sizeModel.qty--;
  //                                 }
  //                                 if (sizeModel.qty <= 0) {
  //                                   listval[index] = false;
  //                                 } else {
  //                                   listval[index] = true;
  //                                 }
  //                               });
  //                             },
  //                             icon: const Icon(Icons.minimize))
  //                       ],
  //                     ),
  //                   );
  //                 } else {
  //                   return Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       CustomButton(
  //                           textbutton: "SELECT",
  //                           onPressed: () {
  //                             List<SizeModel> siz = [];
  //                             for (int i = 0; i < listval.length; i++) {
  //                               if (listval[i]) {
  //                                 siz.add(sizes[i]);
  //                               }
  //                             }
  //                             selectedListColors[indexColor].sizes = siz;
  //                             Get.back();
  //                           })
  //                     ],
  //                   );
  //                 }
  //               }));
  //         }),
  //       );
  //     },
  //   );
  //   update();
  // }
  // getdataSizes() async {
  //   update();
  //   var response = await sizesData.getSizes();
  //   print("================================= Controller $response");
  //   statusRequest = handlingData(response);
  //   if (StatusRequest.success == statusRequest) {
  //     if (response['status'] == "success") {
  //       List responsedata = response['data'];
  //       listSize.addAll(responsedata.map((e) => SizeModel.fromJson(e)));
  //     } else {
  //       Get.showSnackbar(const GetSnackBar(
  //         title: "لايوجد مقاسات",
  //       ));
  //     }
  //   }
  //   update();
  // }
}
