import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/core/funcations/handlinfdatacontroller.dart';
import 'package:adminkingfashion/data/datasource/remote/delierys_data.dart';
import 'package:adminkingfashion/data/model/deliverysmodel.dart';
import 'package:adminkingfashion/data/model/itemsmodel.dart';
import 'package:get/get.dart';

class DeliverysViewController extends GetxController {
  DeliverysDataRemote deliverysDataRemote = DeliverysDataRemote(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  List<DeliverysModel> data = [];

  getdata() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await deliverysDataRemote.getData();
    print("================================= Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List responsedata = response['data'];
        data.addAll(responsedata.map((e) => DeliverysModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  deleteDelivery(
    String? deliveryid,
  ) {
    Map delete = {
      "deliveryid": deliveryid,
    };
    deliverysDataRemote.deleteData(delete);
    data.removeWhere((element) => element.deliveryId.toString() == deliveryid);
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
