import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/core/funcations/handlinfdatacontroller.dart';
import 'package:adminkingfashion/data/datasource/remote/categories_data.dart';
import 'package:adminkingfashion/data/model/categoriesmodel.dart';
import 'package:get/get.dart';

class CategoresViewController extends GetxController {
  CategoriesDataRemote categoriesDataRemote = CategoriesDataRemote(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  List<CategoriesModel> data = [];

  getdata() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await categoriesDataRemote.getData();
    print("================================= Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List responsedata = response['data'];
        data.addAll(responsedata.map((e) => CategoriesModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  deleteCategoriy(String? cateid, String? imagename) async{
    Map delete = {"id": cateid, "image": imagename};
 await   categoriesDataRemote.deleteData(delete);
    data.removeWhere((element) => element.id == cateid);
    update();
  }

  ogToeditCategory(CategoriesModel categoriesModel) {
    Get.toNamed(AppRoute.categoriesedit,
        arguments: {"categoriesModel": categoriesModel});
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
