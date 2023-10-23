import 'package:adminkingfashion/core/class/curd.dart';
import 'package:adminkingfashion/linkapi.dart';

class OrdersDataRemote {
  Crud crud;
  OrdersDataRemote(this.crud);

  pendingOrdersData() async {
    var response = await crud.postData(AppLink.orderspending, {});
    return response.fold((l) => l, (r) => r);
  }

  approvedOrdersData(
    String? orderid,
    String? usersid,
  ) async {
    var response = await crud.postData(AppLink.ordersapproved, {
      "orderid": orderid,
      "userid": usersid,
    });
    return response.fold((l) => l, (r) => r);
  }

  acceptedData() async {
    var response = await crud.postData(AppLink.ordersaccepted, {});
    return response.fold((l) => l, (r) => r);
  }

  doneData(String? orderid, String? userid, String? ordertype) async {
    var response = await crud.postData(AppLink.ordersdone, {
      "orderid": orderid,
      "userid": userid,
      "ordertype": ordertype,
    });
    return response.fold((l) => l, (r) => r);
  }

  archiveOrdersData(String? deliveryid) async {
    var response =
        await crud.postData(AppLink.ordersarchive, {"deliveryid": deliveryid});
    return response.fold((l) => l, (r) => r);
  }

  detalisOrdersData(String orderid) async {
    var response =
        await crud.postData(AppLink.ordersdetalis, {"orderid": orderid});
    return response.fold((l) => l, (r) => r);
  }
}
