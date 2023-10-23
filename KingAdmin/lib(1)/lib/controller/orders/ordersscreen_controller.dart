// ignore: depend_on_referenced_packages

import 'package:adminkingfashion/core/services/services.dart';
import 'package:adminkingfashion/view/screen/orders/accepted.dart';
import 'package:adminkingfashion/view/screen/orders/archive.dart';

import 'package:adminkingfashion/view/screen/orders/pending.dart';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

abstract class HomeSccreenController extends GetxController {
  changePage(int i);
}

class OrderScreenControllerImp extends HomeSccreenController {
  int currntpage = 0;

  MyServices myServices = Get.find();

  List<Widget> listpage = [
    const PendigOrdersPage(),
    const AcceptedOrdersPage(),
    const ArchiveOrdersPage(),
  ];

  List titlebuttomappbar = [
    "طلبات جديدة",
    "الطلبات الموافق عليها",
    "إرشيف الطلبات"
  ];
  List<IconData> iconbuttomappbar = [
    Icons.newspaper_rounded,
    Icons.done_outline_outlined,
    Icons.archive_outlined
  ];

  @override
  changePage(int i) {
    currntpage = i;
    update();
  }
}
