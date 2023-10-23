import 'package:flutter/material.dart';
import 'package:adminkingfashion/controller/orders/ordersdetalis_controller.dart';
import 'package:adminkingfashion/core/class/handlingdataview.dart';
import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class OrderDetalisPage extends StatelessWidget {
  const OrderDetalisPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderDetalisController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("OrderDetalis"),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: GetBuilder<OrderDetalisController>(
            builder: (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: ListView(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Table(children: [
                            const TableRow(children: [
                              Text(
                                "العنصر",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("الكمية",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold)),
                              Text("السعر",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold))
                            ]),

                            // TableRow(
                            //   children:[
                            //   Text("Labtop",textAlign: TextAlign.center,),
                            //   Text("2",textAlign: TextAlign.center,),
                            //   Text("400\$",textAlign: TextAlign.center,)
                            //   ]
                            // ),
                            ...List.generate(
                              controller.data.length,
                              (index) => TableRow(children: [
                                Text(
                                  "${controller.data[index].itmesName}",
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "${controller.data[index].totalecount}",
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "${controller.data[index].totaleprice}\$",
                                  textAlign: TextAlign.center,
                                )
                              ]),
                            )
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                                "إجمالي السعر: ${controller.orderdata.ordersTotleprice}\$",
                                style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (controller.orderdata.ordersType == 1)
                    Card(
                      child: ListTile(
                        title: const Text("عنوان التوصيل",
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                            "${controller.orderdata.addressName}  ${controller.orderdata.addressStreet}"),
                      ),
                    ),
                  // ignore: unrelated_type_equality_checks
                  if (controller.orderdata.ordersType == 1)
                    Card(
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        height: 400,
                        width: double.infinity,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          //   markers: controller.markers.toSet(),
                          //   onTap: (latLng) {
                          //     controller.addMarkers(latLng);
                          //   },
                          initialCameraPosition: controller.cameraPosition!,
                          onMapCreated: (GoogleMapController controllermap) {
                            controller.completercontroller!
                                .complete(controllermap);
                          },
                        ),
                      ),
                    )
                ],
              ),
            ),
          )),
    );
  }
}
