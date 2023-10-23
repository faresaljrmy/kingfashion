import 'dart:io';

import 'package:adminkingfashion/core/class/curd.dart';
import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/linkapi.dart';
import 'package:dartz/dartz.dart';

class CategoriesDataRemote {
  Crud crud;
  CategoriesDataRemote(this.crud);

  getData() async {
    var response = await crud.postData(AppLink.categoriesview, {});
    return response.fold((l) => l, (r) => r);
  }

  addData(Map data) async {
    var response = await crud.postData(AppLink.categoriesadd, data);
    return response.fold((l) => l, (r) => r);
  }

  addDataWithImage(Map data, File file) async {
    var response =
        await crud.addRequestwithFiles(AppLink.categoriesadd, data, file);
    return response.fold((l) => l, (r) => r);
  }

  editData(Map data, [File? file]) async {
    Either<StatusRequest, Map> response;
    if (file == null) {
      response = await crud.postData(AppLink.categoriesedit, data);
      return response.fold((l) => l, (r) => r);
    } else {
      response =
          await crud.addRequestwithFiles(AppLink.categoriesedit, data, file);
      return response.fold((l) => l, (r) => r);
    }
  }

  deleteData(Map data) async {
    var response = await crud.postData(AppLink.categoriesdelete, data);
    return response.fold((l) => l, (r) => r);
  }
  // searchData(search)async{
  //    var response = await crud.postData(AppLink.searchitems,{
  //     "search" :search
  //    });
  //    return response.fold((l) => l, (r) => r);
  // }
}
