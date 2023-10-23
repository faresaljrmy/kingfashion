import 'package:adminkingfashion/controller/colors/viewcolor_controller.dart';
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:adminkingfashion/core/funcations/handlinfdatacontroller.dart';
import 'package:adminkingfashion/core/services/services.dart';
import 'package:adminkingfashion/data/datasource/remote/color_data.dart';
import 'package:adminkingfashion/data/model/colormodel.dart';

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
              color: AppColors.primaryColor, fontWeight: FontWeight.bold),
          middleText:
              " هل تريد بالتاكيد تعديل اللون للتاكيد اضغط نعم للالغاء اضغط لا",
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryColor)),
                onPressed: () {
                  isEdit = true;
                  Get.back();
                },
                child: const Text("نعم")),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryColor)),
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
          colorsModel.userId = myServices.sharedPreferences.getString("id");

          var response = await colorsData.editColor(colorsModel);
          statusRequest = handlingData(response);

          if (StatusRequest.success == statusRequest) {
            // Start backend
            if (response['status'] == "success") {
              Get.snackbar("نجاح", "تم تعديل اللون");
              Get.offNamed(AppRoute.colorspage);
              ViewColorsControllerImp cv = Get.find();
              cv.getdata();
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
    print("changeColor=====${colorsModel.rgb}===");

    isChangeData = true;
    update();
  }
}
