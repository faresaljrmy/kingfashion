import 'package:adminkingfashion/controller/items/itemcolorsize/addcoloritem_controller.dart';
import 'package:adminkingfashion/controller/items/itemcolorsize/editcoloritem_controller.dart';
import 'package:adminkingfashion/core/class/handlingdataview.dart';
import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:adminkingfashion/core/shaerd/custombutton.dart';
import 'package:adminkingfashion/data/model/colormodel.dart';
import 'package:adminkingfashion/data/model/sizemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomExpansionTileEditColor extends StatelessWidget {
  final ColorModel color;
  final int indexcolor;
  const CustomExpansionTileEditColor(
      {super.key, required this.color, required this.indexcolor});

  @override
  Widget build(BuildContext context) {
    Get.put(ItemsAddColorController());
    return GetBuilder<ItemsAddColorController>(builder: (controller) {
      return ExpansionTile(
        title: Text(translateDatabase(color.nameAr, color.name)),
        childrenPadding: const EdgeInsets.all(5),
        leading: CustomButton(
          textbutton: translateDatabase("أضافة", "Add"),
          onPressed: () async {
            await controller.addSize(context, indexcolor);
          },
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(color.sizes != null ? color.sizes!.length.toString() : "0"),
            HandlingDataWidgetRequest(
              statusRequest: controller.statusRequest,
              widget: IconButton(
                  onPressed: () {
                    controller.deleteColor(context, color);
                  },
                  icon: const Icon(Icons.delete)),
            ),
          ],
        ),
        children: color.sizes != null
            ? List.generate(
                color.sizes!.length,
                (indexsize) {
                  SizeModel size = color.sizes![indexsize];
                  return Container(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 100,
                    width: double.infinity,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      translateDatabase(size.namear ?? "خالي",
                                          size.name ?? "Null"),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  Text(
                                      translateDatabase("الكمية: ${size.qty}",
                                          "qty: ${size.qty}"),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(size.dateTime!.split(' ')[0],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  Text(
                                      translateDatabase("السعر: ${size.price}",
                                          "Price: ${size.price}"),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    controller.deleteSize(
                                        context, indexcolor, indexsize);
                                  },
                                  icon: const Icon(Icons.delete)),
                              IconButton(
                                  onPressed: () {
                                    controller.editSize(
                                        context, size, indexcolor, indexsize);
                                  },
                                  icon: const Icon(Icons.edit)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : [],
      );
    });
  }
}
