// ignore_for_file: overridden_fields

import 'package:kingfashion/controller/home_controller.dart';
import 'package:kingfashion/core/class/statusrequest.dart';
import 'package:kingfashion/core/functions/handingdatacontroller.dart';
import 'package:kingfashion/core/services/services.dart';
import 'package:kingfashion/data/datasource/remote/myfavorite_data.dart';
import 'package:kingfashion/data/model/myfavorite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyFavoriteController extends SearchMixController {
  MyFavoriteData favoriteData = MyFavoriteData(Get.find());

  List<MyFavoriteModel> data = [];

  @override
  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

//  key => id items
//  Value => 1 OR 0

  getData() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    var response = await favoriteData
        .getData(myServices.sharedPreferences.getString("id")!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        List responsedata = response['data'];
        data.addAll(responsedata.map((e) => MyFavoriteModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }

  deleteFromFavorite(String favroiteid) async {
    // data.clear();
    // statusRequest = StatusRequest.loading;
    var response = await favoriteData.deleteData(favroiteid);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        data.removeWhere((element) => element.favoriteId == favroiteid);
        update();
      }
      // End
    }
  }

  @override
  void onInit() {
    search = TextEditingController();
    getData();
    super.onInit();
  }
}
