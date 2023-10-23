import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/core/funcations/handlinfdatacontroller.dart';
import 'package:adminkingfashion/core/services/services.dart';
import 'package:adminkingfashion/data/datasource/remote/items_data.dart';
import 'package:adminkingfashion/data/model/categoriesmodel.dart';
import 'package:adminkingfashion/data/model/itemsmodel.dart';
import 'package:get/get.dart';

class ItemsViewController extends GetxController {
  ItemsDataRemote itemsDataRemote = ItemsDataRemote(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  List<CategoriesModel> categories = [];
  List<ItemsModel> data = [];

  getdata() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await itemsDataRemote.getDataWithColors();
    // print("================================= Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List responsedata = response['data'];
        data.addAll(responsedata.map((e) => ItemsModel.fromJsonWithColor(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  deleteItems(String? itemid, String? imagename) async {
    Map delete = {
      "id": itemid,
      "imagename": imagename,
      "userid": myServices.sharedPreferences.getString("id")
    };
    var response = await itemsDataRemote.deleteData(delete);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        data.removeWhere((element) => element.id == itemid);
      } else if (response['status'] == "failure" &&
          response['message'] == "hasrefrences") {
        await Get.defaultDialog(
            title: "خطأ",
            middleText: "لايمكن حذف المنتج لانه مرتبط بحسابات اخرى",
            buttonColor: AppColors.thirdColor,
            onCancel: () {
              Get.back();
            },
            onConfirm: () {
              Get.back();
            });
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  ogToeditItems(ItemsModel itemsModel) {
    Get.toNamed(AppRoute.itemsedit, arguments: {"itemsModel": itemsModel});
  }

  myback() {
    Get.offAllNamed(AppRoute.dashboard);
    return Future.value(false);
  }

  @override
  void onInit() {
    getdata();
    super.onInit();
  }
}
