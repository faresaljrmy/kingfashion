import 'package:adminkingfashion/core/class/curd.dart';
import 'package:adminkingfashion/linkapi.dart';

class UsersDataRemote {
  Crud crud;
  UsersDataRemote(this.crud);

  getData() async {
    var response = await crud.postData(AppLink.usersview, {});
    return response.fold((l) => l, (r) => r);
  }

  // deleteData(Map data) async {
  //   var response = await crud.postData(AppLink.deliverdelete, data);
  //   return response.fold((l) => l, (r) => r);
  // }

  // searchData(search)async{
  //    var response = await crud.postData(AppLink.searchitems,{
  //     "search" :search
  //    });
  //    return response.fold((l) => l, (r) => r);
  // }
}
