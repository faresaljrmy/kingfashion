import 'package:adminkingfashion/core/class/curd.dart';
import 'package:adminkingfashion/linkapi.dart';

class DeliverysDataRemote {
  Crud crud;
  DeliverysDataRemote(this.crud);

  getData() async {
    var response = await crud.postData(AppLink.deliveryview, {});
    return response.fold((l) => l, (r) => r);
  }

  addData(Map data) async {
    var response = await crud.postData(AppLink.deliveryadd, data);
    return response.fold((l) => l, (r) => r);
  }

  deleteData(Map data) async {
    var response = await crud.postData(AppLink.deliverdelete, data);
    return response.fold((l) => l, (r) => r);
  }

  // searchData(search)async{
  //    var response = await crud.postData(AppLink.searchitems,{
  //     "search" :search
  //    });
  //    return response.fold((l) => l, (r) => r);
  // }
}
