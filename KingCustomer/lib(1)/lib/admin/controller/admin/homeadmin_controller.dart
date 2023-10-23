import 'package:get/get.dart';
import 'package:kingfashion/core/class/statusrequest.dart';
import 'package:kingfashion/core/constant/routes.dart';
import 'package:kingfashion/core/functions/handingdatacontroller.dart';
import 'package:kingfashion/core/services/services.dart';
import 'package:kingfashion/admin/data/datasource/remote/admin/homeadmin_data.dart';
import 'package:kingfashion/data/model/categoriesmodel.dart';
import 'package:kingfashion/data/model/colormodel.dart';
import 'package:kingfashion/data/model/couponmodel.dart';
import 'package:kingfashion/data/model/itemsmodel.dart';
import 'package:kingfashion/data/model/ordersmodel.dart';
import 'package:kingfashion/data/model/sizemodel.dart';
import 'package:kingfashion/data/model/usersmodel.dart';

abstract class HomeAdminController extends GetxController {
  initialData();
  getdata();
  goToItems();
  goToCategories();
  goToColors();
  goToSizes();
  goToCoupons();
  goToUsers();
  goToOrders();
}

class HomeAdminControllerImp extends HomeAdminController {
  MyServices myServices = Get.find();
  String? username;
  String? id;
  List<ItemsModel> listItems = [];
  List<CategoriesModel> listcategories = [];
  List<ColorModel> listColors = [];
  List<SizeModel> listSizes = [];
  List<CouponModel> listCoupon = [];
  List<UsersModel> listUsers = [];
  List<OrdersModel> listOrders = [];
  late StatusRequest statusRequest;
  HomeAdminData homedata = HomeAdminData(Get.find());
  String? lang;

  @override
  initialData() async {
    username = myServices.sharedPreferences.getString("username");
    id = myServices.sharedPreferences.getString("id");
    lang = myServices.sharedPreferences.getString("lang");
    print("Home Admin===$lang====================");
    await getdata();
    update();
  }

  @override
  getdata() async {
    statusRequest = StatusRequest.loading;
    var response = await homedata.getData();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        listcategories = [];
        List responsedata = response['categories']['data'];
        listcategories
            .addAll(responsedata.map((e) => CategoriesModel.fromJson(e)));
        listItems.clear();
        responsedata = response['items']['data'];
        listItems.addAll(responsedata.map((e) => ItemsModel.fromJson(e)));
        listColors.clear();
        responsedata = response['colors']['data'];
        listColors.addAll(responsedata.map((e) => ColorModel.fromJson(e)));
        listSizes.clear();
        responsedata = response['sizes']['data'];
        listSizes.addAll(responsedata.map((e) => SizeModel.fromJson(e)));
        listUsers.clear();
        responsedata = response['users']['data'];
        listUsers.addAll(responsedata.map((e) => UsersModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    } else {
      print("StatusRequest.none================================");
      statusRequest = StatusRequest.none;
    }
    update();
  }

  @override
  goToCategories() {
    // statusRequest = StatusRequest.loading;
    Get.toNamed(AppRoute.categoriespage,
        arguments: {"listcategories": listcategories, "listItems": listItems});
    // statusRequest = StatusRequest.success;
  }

  @override
  goToColors() {
    Get.toNamed(AppRoute.colorspage, arguments: {"listColors": listColors});
  }

  @override
  goToCoupons() {}

  @override
  goToItems() {}

  @override
  goToOrders() {}

  @override
  goToSizes() {
    Get.toNamed(AppRoute.sizespage, arguments: {"listSizes": listSizes});
  }

  @override
  goToUsers() {}
  @override
  void onInit() async {
    await initialData();
    super.onInit();
  }
}
