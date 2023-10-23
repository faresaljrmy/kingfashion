// ignore: depend_on_referenced_packages

import 'package:adminkingfashion/controller/searchmax_controller.dart';
import 'package:adminkingfashion/core/services/services.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

abstract class HomePageController extends SearchMaxController {
  // getdata();
  // initialData();
  // goToFavorite();
  // goToItems(List categories, int selectedcat, String categoryid);
}

class HomePageControllerImp extends HomePageController {
  MyServices myServices = Get.find();

// HomePageDataRemote homePageDataRemote = HomePageDataRemote(Get.find());

  //  List categories =[];
  //  String? lang;
  //  List itmes = [];
  //  List settingstxt = [];

  //   String? username;

  //   @override
  // getdata()async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await homePageDataRemote.getData();
  //   print("================================= Controller $response");
  //    statusRequest = handlingData(response);
  //    if(StatusRequest.success == statusRequest){
  //     if(response['status'] == "success"){

  //       categories.addAll(response['categories']);
  //        itmes.addAll(response['itmes']);
  //        settingstxt.addAll(response['settingtxt']);

  //     }else{
  //       statusRequest = StatusRequest.failure;
  //     }
  //    }

  //   update();
  // }

  // @override
  // void onInit() {
  // search = TextEditingController();
  // // FirebaseMessaging.instance.subscribeToTopic("users");
  //  getdata();
  //  initialData();
  //   super.onInit();
  // }

  // @override
  // goToItems( categories,  selectedcat,categoryid) {

  //   Get.toNamed(AppRoute.items,arguments: {
  //     "categroies": categories,
  //     "selectedcat": selectedcat,
  //     "categoryid":categoryid
  //   });
  // }

  // @override
  // initialData() {
  // lang =myServices.sharedPreferences.getString("lang");

  // }

  // @override
  // goToFavorite() {
  //  Get.toNamed(AppRoute.myfavroite);
  // }
}
