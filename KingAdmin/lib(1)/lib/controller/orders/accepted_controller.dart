import 'package:adminkingfashion/data/model/ordersmodel.dart';
import 'package:get/get.dart';
import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/funcations/handlinfdatacontroller.dart';
import 'package:adminkingfashion/core/services/services.dart';
import 'package:adminkingfashion/data/datasource/remote/orders_data.dart';

class AcceptedController extends GetxController {
  OrdersDataRemote acceptedDataRemote = Get.put(OrdersDataRemote(Get.find()));

  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  List<OrdersModel> data = [];

  String printOrdertype(String val) {
    if (val == "1") {
      return "توصيل";
    } else {
      return "إستلام من المحل";
    }
  }

  String printpaymentmethod(String val) {
    if (val == "1") {
      return "بطافة إتئمان";
    } else {
      return "نقد عند التوصيل";
    }
  }

  String printOrderStatus(String val) {
    if (val == "0") {
      return "بإنتظار الموافقة";
    } else if (val == "1") {
      return "يتم تجهيز الطلب";
    } else if (val == "2") {
      return "جاهز للتسليم لعامل التوصيل";
    } else if (val == "3") {
      return "على الطريق";
    } else {
      return "مؤرشف";
    }
  }

  getacceptedOrders() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await acceptedDataRemote.acceptedData();

    statusRequest = handlingData(response);
    print("==============$response==========");
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == 'success') {
        List dataresponse = response['data'];
        data.addAll(dataresponse.map((e) => OrdersModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  doneOrders(
    String? orderid,
    String? userid,
    String? ordertype,
  ) async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await acceptedDataRemote.doneData(orderid, userid, ordertype);
    statusRequest = handlingData(response);
    print("==============$response==========");
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == 'success') {
        getacceptedOrders();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future refershOrders() async {
    try {
      var response = await acceptedDataRemote.acceptedData();
      print(response);
      if (response['status'] == 'success') {
        List dataresponse = response['data'];
        data.clear();
        data.addAll(dataresponse.map((e) => OrdersModel.fromJson(e)));
      }
    } catch (on) {
      Get.snackbar("Error", "Not Connected");
    }
    update();
  }

  @override
  void onInit() {
    getacceptedOrders();
    super.onInit();
  }
}
