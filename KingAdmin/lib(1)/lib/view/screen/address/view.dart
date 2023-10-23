
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    // AddAddressController controllerpage = Get.put(AddAddressController());
    // final Completer<GoogleMapController> _controller =
    //   Completer<GoogleMapController>();

  
    return Scaffold(
       floatingActionButton: FloatingActionButton(onPressed: (){},
       child:const Icon(Icons.add),
       ),
        appBar: AppBar(
       title: Text("60".tr),
     ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: const Column(
          children: [
          
      //    if(controllerpage.kGooglePlex != null)  Expanded(
      //        child:GoogleMap(
      //   mapType: MapType.normal,
      //   markers: controllerpage.markers.toSet(),
      //   onTap: (latLng) {
      //     controllerpage.addMarkers(latLng);
      //   },
      //   initialCameraPosition: controllerpage.kGooglePlex!,
      //   onMapCreated:(GoogleMapController controllermap){
      //     controllerpage.completercontroller!.complete(controllermap);
      //   },
      // ),
            // )
            

          ],
        ),
      ),

    );
  }
}