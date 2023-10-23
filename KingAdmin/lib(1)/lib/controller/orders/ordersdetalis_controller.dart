import 'dart:async';
import 'package:adminkingfashion/data/datasource/remote/orders_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:get/get.dart';
import 'package:adminkingfashion/core/funcations/handlinfdatacontroller.dart';
import 'package:adminkingfashion/data/model/oderdetalismodel.dart';
import 'package:adminkingfashion/data/model/ordersmodel.dart';

class OrderDetalisController extends GetxController {
  late StatusRequest statusRequest;
  OrdersDataRemote orderDetalisDataRemote = OrdersDataRemote(Get.find());
  List<OrderDetalisModel> data = [];
  late OrdersModel orderdata;

  Completer<GoogleMapController>? completercontroller;

  List<Marker> markers = [];

  CameraPosition? cameraPosition = const CameraPosition(
    target: LatLng(42.4, 45.66),
    zoom: 14.4746,
  );
  Position? postion;

  double? lat;
  double? long;

  getOrdersDetalis() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    var response = await orderDetalisDataRemote
        .detalisOrdersData(orderdata.ordersId.toString());
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == 'success') {
        List dataresponse = response['data'];
        data.addAll(dataresponse.map((e) => OrderDetalisModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  addMarkers(LatLng latLng) {
    markers.clear();
    markers.add(Marker(markerId: const MarkerId("1"), position: latLng));
    lat = latLng.latitude;
    long = latLng.longitude;
    update();
  }

  goToPageAddDetailsAddress() {
    // Get.toNamed(AppRoute.addressadddetails,
    //     arguments: {"lat": lat.toString(), "long": long.toString()});
  }

  getCurrentLocation() async {
    postion = await Geolocator.getCurrentPosition();
    cameraPosition = CameraPosition(
      target: LatLng(postion!.latitude, postion!.longitude),
      zoom: 14.4746,
    );
    statusRequest = StatusRequest.none;
    update();
  }

  @override
  void onInit() {
    orderdata = Get.arguments['orderslist'];
    // getCurrentLocation();
    getOrdersDetalis();
    cameraPosition;
    completercontroller = Completer<GoogleMapController>();
    super.onInit();
  }
}
