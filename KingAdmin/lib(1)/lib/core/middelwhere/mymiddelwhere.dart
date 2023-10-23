// ignore: depend_on_referenced_packages

import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/core/services/services.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class MyMiddleWare extends GetMiddleware {
  MyServices myServices = Get.find();

  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getString("step") == "1") {
      return const RouteSettings(name: AppRoute.dashboard);
    }
    return null;
  }
}
