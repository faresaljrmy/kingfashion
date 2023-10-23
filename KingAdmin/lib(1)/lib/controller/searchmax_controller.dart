import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/data/datasource/remote/searchdata.dart';

class SearchMaxController extends GetxController {
  SearchDataRemote searchDataRemote = SearchDataRemote(Get.find());
  late StatusRequest statusRequest;
// ItemsModel? itemsModel;

  TextEditingController? search;
  bool? issearch = false;

  checkSearch(val) {
    if (val == "") {
      statusRequest = StatusRequest.none;
      issearch = false;
    }
    update();
  }

  onSearch() {
    issearch = true;
    // searchData();
    update();
  }

// searchData()async{
// statusRequest = StatusRequest.loading;
// var response = await searchDataRemote.searchData(search!.text);
// print("=============================== Controller $response ");
// statusRequest = handlingData(response);

// if(StatusRequest.success == statusRequest){
//   if(response['status'] == 'success'){

//     List dataresponse = response['data'];
//     // datasearch.addAll(dataresponse.map((e) => ItemsModel.fromJson(e)));

//   }else{
//     statusRequest = StatusRequest.failure;
//   }
// }
//  update();
// }

  goToItemsDetalis(itemsModel) {
    Get.offAndToNamed(AppRoute.itemsdetails,
        arguments: {"itemsdetalis": itemsModel});
  }

  @override
  void dispose() {
    search!.dispose();
    super.dispose();
  }
}
