import 'package:adminkingfashion/core/class/curd.dart';
import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/linkapi.dart';
import 'package:dartz/dartz.dart';

class ItemColorSizeDataRemote {
  Crud crud;
  ItemColorSizeDataRemote(this.crud);

  getData() async {
    var response = await crud.postData(AppLink.itemsview, {});
    return response.fold((l) => l, (r) => r);
  }

  addDataSize(Map data) async {
    var response = await crud.postData(AppLink.itemcolorsizeadd, data);
    return response.fold((l) => l, (r) => r);
  }

  editDataSize(Map data) async {
    Either<StatusRequest, Map> response;
    response = await crud.postData(AppLink.itemcolorsizeedit, data);
    return response.fold((l) => l, (r) => r);
  }

  deleteDataSize(Map data) async {
    var response = await crud.postData(AppLink.itemcolorsizedelete, data);
    return response.fold((l) => l, (r) => r);
  }

  deleteDataAllSizeInColor(Map data) async {
    var response = await crud.postData(AppLink.itemallsizecolordelete, data);
    return response.fold((l) => l, (r) => r);
  }
  // searchData(search)async{
  //    var response = await crud.postData(AppLink.searchitems,{
  //     "search" :search
  //    });
  //    return response.fold((l) => l, (r) => r);
  // }
}
