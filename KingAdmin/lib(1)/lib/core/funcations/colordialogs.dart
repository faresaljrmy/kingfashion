import 'package:adminkingfashion/core/shaerd/custombutton.dart';
import 'package:adminkingfashion/data/model/colormodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<ColorModel> allColorToAddItem = [];

class ColorDialogs {
  BuildContext? context;
  List<ColorModel>? selectedColors;
  List<ColorModel>? allColors;
  ColorDialogs({this.context, this.selectedColors, this.allColors});
  Future<List<ColorModel>> chooseColors(int type) async {
    selectedColors ??= [];
    // allColors ??= [];
    await showDialog(
      context: context!,
      builder: (BuildContext context) {
        List<ColorModel> colors = [];
        List<ColorModel> selColor = [];
        if (type == 1) {
          colors = allColors ?? [];
          for (int i = 0; i < colors.length; i++) {
            colors[i].isSelected = false;
          }
        } else if (type == 2) {
          colors = allColors ?? [];
          for (int i = 0; i < selectedColors!.length; i++) {
            colors.removeWhere((element) =>
                element.id.toString() == selectedColors![i].id.toString());
          }
          for (int i = 0; i < colors.length; i++) {
            colors[i].isSelected = false;
          }
        }
        return AlertDialog(
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(colors.length + 1, (int index) {
                  if (index < colors.length) {
                    ColorModel colorModel = colors[index];
                    return CheckboxListTile(
                      title: Text(colorModel.name ?? "null"),
                      subtitle: Text(colorModel.rgb ?? "null"),
                      value: colorModel.isSelected,
                      onChanged: (value) {
                        setState(() {
                          if (value!) {
                            colors[index].isSelected = true;
                          } else {
                            colors[index].isSelected = false;
                          }
                        });
                      },
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                            textbutton: "SELECT",
                            onPressed: () {
                              selectedColors!.addAll(colors
                                  .where((element) => element.isSelected)
                                  .toList());
                              Get.back();
                            })
                      ],
                    );
                  }
                }));
          }),
        );
      },
    );
    // return Future.delayed(const Duration(milliseconds: 100),);
    return Future.value(selectedColors);
  }
}
