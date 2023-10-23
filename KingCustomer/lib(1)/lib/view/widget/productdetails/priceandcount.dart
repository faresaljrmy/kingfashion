import 'package:kingfashion/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:kingfashion/core/functions/translatefatabase.dart';
import 'package:kingfashion/data/model/sizemodel.dart';

class PriceAndCountItems extends StatelessWidget {
  final void Function()? onAdd;
  final void Function()? onRemove;
  // final String price;
  final SizeModel size;
  final String count;
  const PriceAndCountItems(
      {Key? key,
      required this.onAdd,
      required this.onRemove,
      // required this.price,
      required this.size,
      required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 10),
                  margin: const EdgeInsets.only(right: 50),
                  // width: 50,
                  // height: 50,
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.black)),
                  child: Text(
                    "${size.qty} :qty",
                    style: const TextStyle(
                        fontSize: 16,
                        height: 1.1,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
              // const Spacer(),
              Text(
                translateDatabase("${size.namear} - ${size.symbol}",
                    "${size.symbol} - ${size.name}"),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "${size.price} \$",
                style: TextStyle(
                    decoration: (size.descount == null ||
                            size.descount.toString() == "0")
                        ? TextDecoration.none
                        : TextDecoration.lineThrough,
                    color: AppColor.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.1),
              )
            ],
          ),
          Row(
            children: [
              Row(
                children: [
                  IconButton(onPressed: onAdd, icon: const Icon(Icons.add)),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(bottom: 2),
                      width: 50,
                      // height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Text(
                        size.qtycart != null ? size.qtycart.toString() : "0",
                        style: const TextStyle(fontSize: 20, height: 1.1),
                      )),
                  IconButton(
                      onPressed: onRemove, icon: const Icon(Icons.remove)),
                ],
              ),
              const Spacer(),
              (size.descount == null || size.descount.toString() == "0")
                  ? Container()
                  : Text(
                      "${size.price} \$",
                      style: const TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.1),
                    )
            ],
          ),
        ],
      ),
    );
  }
}
