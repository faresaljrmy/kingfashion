import 'dart:io';

import 'package:adminkingfashion/core/class/curd.dart';
import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/linkapi.dart';
import 'package:dartz/dartz.dart';

class ItemsDataRemote {
  Crud crud;
  ItemsDataRemote(this.crud);

  getData() async {
    var response = await crud.postData(AppLink.itemsview, {});
    return response.fold((l) => l, (r) => r);
  }

  getDataWithColors() async {
    var response = await crud.postData(AppLink.itemsviewwithcolorsize, {});
    return response.fold((l) => l, (r) => r);
  }

  addData(Map data, File file) async {
    var response = await crud.addRequestwithFiles(AppLink.itemsadd, data, file);
    return response.fold((l) => l, (r) => r);
  }

  editData(Map data, [File? file]) async {
    Either<StatusRequest, Map> response;
    if (file == null) {
      response = await crud.postData(AppLink.itemsedit, data);
      return response.fold((l) => l, (r) => r);
    } else {
      response = await crud.addRequestwithFiles(AppLink.itemsedit, data, file);
      return response.fold((l) => l, (r) => r);
    }
  }

  deleteData(Map data) async {
    var response = await crud.postData(AppLink.itemsdelete, data);
    return response.fold((l) => l, (r) => r);
  }

  addItemColorSize(Map data) async {
    var response = await crud.postData(AppLink.itemcolorsizeadd, data);
    return response.fold((l) => l, (r) => r);
  }
  // searchData(search)async{
  //    var response = await crud.postData(AppLink.searchitems,{
  //     "search" :search
  //    });
  //    return response.fold((l) => l, (r) => r);
  // }
}
