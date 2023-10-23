import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/core/class/statusrequest.dart';
import 'package:kingfashion/core/constant/color.dart';
import 'package:kingfashion/core/functions/handingdatacontroller.dart';
import 'package:kingfashion/core/services/services.dart';
import 'package:kingfashion/admin/data/datasource/remote/admin/color_data.dart';
import 'package:kingfashion/data/model/colormodel.dart';

abstract class EditColorController extends GetxController {
  editColor();
}

class EditColorControllerImp extends EditColorController {
  // create some values
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

// ValueChanged<Color> callback
  // void Function(Color) changeColor(Color color) {
  //   pickerColor = color;
  // }

  late TextEditingController name;
  late TextEditingController namear;
  String rgb = "";
  bool isEdit = false;
  bool isChangeData = false;
  ColorModel colorsModel = ColorModel();
  // File
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  ColorsData colorsData = ColorsData(Get.find());

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  @override
  void onInit() async {
    colorsModel = Get.arguments["color"];
    // print("${colorsModel.name}========================");
    currentColor = Color(int.parse(colorsModel.rgb ?? "ffffffff", radix: 16));
    name = TextEditingController(text: colorsModel.name);
    namear = TextEditingController(text: colorsModel.nameAr);
    statusRequest = StatusRequest.success;
    name.addListener(() {
      isChangeData = true;
      update();
    });
    namear.addListener(() {
      isChangeData = true;
      update();
    });
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    namear.dispose();
    super.dispose();
  }

  @override
  editColor() async {
    if (isChangeData) {
      await Get.defaultDialog(
          title: "تاكيد",
          titleStyle: const TextStyle(
              color: AppColor.primaryColor, fontWeight: FontWeight.bold),
          middleText:
              " هل تريد بالتاكيد تعديل اللون للتاكيد اضغط نعم للالغاء اضغط لا",
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColor.primaryColor)),
                onPressed: () {
                  isEdit = true;
                  Get.back();
                },
                child: const Text("نعم")),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColor.primaryColor)),
                onPressed: () {
                  isEdit = false;
                  Get.back();
                },
                child: const Text("لا"))
          ]);

      if (isEdit) {
        if (formstate.currentState!.validate()) {
          statusRequest = StatusRequest.loading;
          colorsModel.name = name.text;
          colorsModel.nameAr = namear.text;

          var response = await colorsData.editColor(colorsModel);
          statusRequest = handlingData(response);
          if (StatusRequest.success == statusRequest) {
            // Start backend
            print("response==$response=================");
            if (response['status'] == "success") {
              Get.rawSnackbar(
                  title: "اشعار",
                  messageText: const Text("تم تعديل اللون بنجاح "));
              name.text = "";
              namear.text = "";
              colorsModel = ColorModel();
              // Get.off(page)
            } else {
              statusRequest = StatusRequest.failure;
            }
            // End
          }
        }
      }
    }
    // Get.offNamed(AppRoute.colorsAddpage);
    update();
  }

  changeColor() {
    currentColor = pickerColor;
    colorsModel.rgb = pickerColor.value.toRadixString(16);
    isChangeData = true;
    update();
  }
}
