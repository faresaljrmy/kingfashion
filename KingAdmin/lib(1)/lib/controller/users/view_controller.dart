import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/core/funcations/handlinfdatacontroller.dart';
import 'package:adminkingfashion/data/datasource/remote/users_data.dart';
import 'package:adminkingfashion/data/model/usersmodel.dart';
import 'package:get/get.dart';

class UsersViewController extends GetxController {
  UsersDataRemote usersDataRemote = UsersDataRemote(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  List<UsersModel> data = [];

  getdata() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await usersDataRemote.getData();
    print("================================= Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List responsedata = response['data'];
        data.addAll(responsedata.map((e) => UsersModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
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
