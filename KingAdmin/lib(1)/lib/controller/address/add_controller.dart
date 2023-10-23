import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:get/get.dart';

class AddAddressController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;

  Completer<GoogleMapController>? completercontroller;

  List<Marker> markers = [];

  CameraPosition? kGooglePlex;
  Position? postion;

  double? lat;
  double? long;

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
    kGooglePlex = CameraPosition(
      target: LatLng(postion!.latitude, postion!.longitude),
      zoom: 14.4746,
    );
    statusRequest = StatusRequest.none;
    update();
  }

  @override
  void onInit() {
    getCurrentLocation();
    completercontroller = Completer<GoogleMapController>();
    super.onInit();
  }
}
