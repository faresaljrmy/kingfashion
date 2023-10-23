import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:adminkingfashion/core/shaerd/custombutton.dart';
import 'package:adminkingfashion/core/shaerd/customtextfilead.dart';
import 'package:adminkingfashion/data/model/sizemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SizeDialogs {
  BuildContext? context;
  List<SizeModel>? selectedSizes;
  List<SizeModel>? allSizes;
  SizeModel? sizeToEdit;
  String? langCode;
  SizeDialogs(
      {this.context,
      this.selectedSizes,
      this.allSizes,
      this.langCode,
      this.sizeToEdit});

  Future<List<SizeModel>> chooseSizes() async {
    // selectedSizes ??= allSizes;
    await showDialog(
      context: context!,
      builder: (BuildContext context) {
        List<SizeModel> sizes = selectedSizes ?? allSizes ?? [];
        return AlertDialog(
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(sizes.length + 1, (int index) {
                  if (index < sizes.length) {
                    SizeModel sizeModel = sizes[index];
                    if (sizeModel.qty == null ||
                        sizeModel.qty.toString().isEmpty) {
                      sizeModel.qty = 0;
                    }
                    return ListTile(
                      contentPadding: const EdgeInsets.all(5),
                      titleAlignment: ListTileTitleAlignment.center,
                      trailing: Checkbox(
                        value: sizeModel.isSelected ?? false,
                        onChanged: (value) {
                          if (value!) {
                            sizeModel.qty = 1;
                          } else {
                            sizeModel.qty = 0;
                            // selectedSize.removeWhere(
                            //     (element) => element.id == sizeModel.id);
                          }
                          sizeModel.isSelected = value;
                          setState(() => sizes[index] = sizeModel);
                        },
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(sizeModel.symbol ?? "null"),
                          Text(sizeModel.name ?? "null"),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  sizeModel.qty++;
                                  sizeModel.isSelected = true;
                                  sizes[index] = sizeModel;
                                });
                              },
                              icon: const Icon(Icons.add)),
                          Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(bottom: 2),
                              width: 50,
                              // height: 30,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Text(
                                sizeModel.qty != null
                                    ? sizeModel.qty.toString()
                                    : "0",
                                style:
                                    const TextStyle(fontSize: 20, height: 1.1),
                              )),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (sizeModel.qty > 0) {
                                    sizeModel.qty--;
                                  }
                                  if (sizeModel.qty <= 0) {
                                    sizeModel.isSelected = false;
                                  } else {
                                    sizeModel.isSelected = true;
                                  }
                                  sizes[index] = sizeModel;
                                });
                              },
                              icon: const Icon(Icons.remove))
                        ],
                      ),
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                            textbutton: "SELECT",
                            onPressed: () {
                              selectedSizes = sizes;
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
    return Future.value(selectedSizes);
  }

  Future<SizeModel> addSize() async {
    TextEditingController count = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController descount = TextEditingController();
    GlobalKey<FormState> formstateaddcate = GlobalKey<FormState>();

    SizeModel selectedSize = SizeModel();
    SizeModel size = SizeModel();
    await showDialog(
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translateDatabase("أضافة مقاس", "Add Size")),
          // contentPadding: const EdgeInsets.all(10),
          actions: [
            Form(
              key: formstateaddcate,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: translateDatabase(
                            Alignment.center, Alignment.center),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15),
                          // boxShadow: [Bo]
                        ),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: DropdownButton(
                          borderRadius: BorderRadius.circular(15),
                          elevation: 3,
                          value: translateDatabase(
                              selectedSize.namear, selectedSize.name),
                          hint: Text(
                              translateDatabase("اختر المقاس", "Select Size")),
                          items: List.generate(allSizes!.length, (index) {
                            SizeModel sizeModel = allSizes![index];
                            return DropdownMenuItem(
                              value: translateDatabase(
                                  sizeModel.namear, sizeModel.name),
                              child: Text(
                                translateDatabase(
                                    sizeModel.namear, sizeModel.name),
                              ),
                            );
                          }),
                          onChanged: (value) {
                            setState(
                              () {
                                if (value != null) {
                                  selectedSize = allSizes!
                                      .where(
                                        (element) =>
                                            translateDatabase(
                                                element.namear, element.name) ==
                                            value,
                                      )
                                      .first;
                                }
                              },
                            );
                          },
                        ),
                      ),
                      ////// TextForm Count
                      CustomTextFormGolable(
                        hinttext: translateDatabase("ادخل الكمية", "Enter Qty"),
                        mycontroller: count,
                        // key: formstate,
                        valid: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (value.isNotEmpty) {
                              if (double.parse(value.toString()) > 0) {
                                return null;
                              } else {
                                return translateDatabase(
                                    "لايمكن ادخال قيمة صفر",
                                    "Can not Enter Zero Value");
                              }
                            } else {
                              return translateDatabase(
                                  "املئ الحقل", "Fill Text");
                            }
                          } else {
                            return translateDatabase("املئ الحقل", "Fill Text");
                          }
                        },
                        isNumber: true,
                        labeltext: translateDatabase("الكمية", "Qty"),
                      ),

                      ////// TextForm Price
                      CustomTextFormGolable(
                        hinttext:
                            translateDatabase("ادخل السعر", "Enter Price"),
                        mycontroller: price,
                        valid: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (value.isNotEmpty) {
                              if (double.parse(value.toString()) > 0) {
                                return null;
                              } else {
                                return translateDatabase(
                                    "لايمكن ادخال قيمة صفر",
                                    "Can not Enter Zero Value");
                              }
                            } else {
                              return translateDatabase(
                                  "املئ الحقل", "Fill Text");
                            }
                          } else {
                            return translateDatabase("املئ الحقل", "Fill Text");
                          }
                        },
                        isNumber: true,
                        labeltext: translateDatabase("السعر", "Price"),
                      ),

////// TextForm Descount
                      CustomTextFormGolable(
                        hinttext:
                            translateDatabase("ادخل الخصم", "Enter Discount"),
                        mycontroller: descount,
                        valid: (value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return translateDatabase(
                                  "املئ الحقل", "Fill Text");
                            } else {
                              return null;
                            }
                          } else {
                            return translateDatabase("املئ الحقل", "Fill Text");
                          }
                        },
                        isNumber: true,
                        labeltext: translateDatabase("الخصم", "Discount"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                              textbutton: translateDatabase("أضافة", "Add"),
                              onPressed: () {
                                if (formstateaddcate.currentState!.validate()) {
                                  if (selectedSize.id != null) {
                                    selectedSize.qty = count.text;
                                    selectedSize.price = price.text;
                                    selectedSize.descount = descount.text;
                                    size = selectedSize;
                                    Get.back();
                                  } else {
                                    // Get.snackbar(
                                    //     backgroundColor: Colors.red,
                                    //     translateDatabase("تنبية", "Alert"),
                                    //     translateDatabase("يرجى اختيار المقاس ",
                                    //         "Please Choose Size"));
                                  }
                                }
                              }),
                          CustomButton(
                              textbutton: translateDatabase("الغاء", "Cancel"),
                              onPressed: () {
                                selectedSize = SizeModel();
                                Get.back();
                              })
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
    return Future.value(size);
  }

  Future<SizeModel> editSize() async {
    TextEditingController count = TextEditingController(text: sizeToEdit!.qty);
    TextEditingController price =
        TextEditingController(text: sizeToEdit!.price);
    TextEditingController descount =
        TextEditingController(text: sizeToEdit!.descount);
    GlobalKey<FormState> formstateaddcate = GlobalKey<FormState>();

    SizeModel selectedSize = sizeToEdit ?? SizeModel();
    SizeModel size = SizeModel();
    await showDialog(
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translateDatabase("أضافة مقاس", "Add Size")),
          // contentPadding: const EdgeInsets.all(10),
          actions: [
            Form(
              key: formstateaddcate,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: translateDatabase(
                            Alignment.center, Alignment.center),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15),
                          // boxShadow: [Bo]
                        ),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: DropdownButton(
                          borderRadius: BorderRadius.circular(15),
                          elevation: 3,
                          value: translateDatabase(
                              selectedSize.namear, selectedSize.name),
                          hint: Text(
                              translateDatabase("اختر المقاس", "Select Size")),
                          items: List.generate(allSizes!.length, (index) {
                            SizeModel sizeModel = allSizes![index];
                            return DropdownMenuItem(
                              value: translateDatabase(
                                  sizeModel.namear, sizeModel.name),
                              child: Text(
                                translateDatabase(
                                    sizeModel.namear, sizeModel.name),
                              ),
                            );
                          }),
                          onChanged: (value) {
                            setState(
                              () {
                                if (value != null) {
                                  selectedSize = allSizes!
                                      .where(
                                        (element) =>
                                            translateDatabase(
                                                element.namear, element.name) ==
                                            value,
                                      )
                                      .first;
                                }
                              },
                            );
                          },
                        ),
                      ),
                      ////// TextForm Count
                      CustomTextFormGolable(
                        hinttext: translateDatabase("ادخل الكمية", "Enter Qty"),
                        mycontroller: count,
                        // key: formstate,
                        valid: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (value.isNotEmpty) {
                              if (double.parse(value.toString()) > 0) {
                                return null;
                              } else {
                                return translateDatabase(
                                    "لايمكن ادخال قيمة صفر",
                                    "Can not Enter Zero Value");
                              }
                            } else {
                              return translateDatabase(
                                  "املئ الحقل", "Fill Text");
                            }
                          } else {
                            return translateDatabase("املئ الحقل", "Fill Text");
                          }
                        },
                        isNumber: true,
                        labeltext: translateDatabase("الكمية", "Qty"),
                      ),

                      ////// TextForm Price
                      CustomTextFormGolable(
                        hinttext:
                            translateDatabase("ادخل السعر", "Enter Price"),
                        mycontroller: price,
                        valid: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (value.isNotEmpty) {
                              if (double.parse(value.toString()) > 0) {
                                return null;
                              } else {
                                return translateDatabase(
                                    "لايمكن ادخال قيمة صفر",
                                    "Can not Enter Zero Value");
                              }
                            } else {
                              return translateDatabase(
                                  "املئ الحقل", "Fill Text");
                            }
                          } else {
                            return translateDatabase("املئ الحقل", "Fill Text");
                          }
                        },
                        isNumber: true,
                        labeltext: translateDatabase("السعر", "Price"),
                      ),

////// TextForm Descount
                      CustomTextFormGolable(
                        hinttext:
                            translateDatabase("ادخل الخصم", "Enter Discount"),
                        mycontroller: descount,
                        valid: (value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return translateDatabase(
                                  "املئ الحقل", "Fill Text");
                            } else {
                              return null;
                            }
                          } else {
                            return translateDatabase("املئ الحقل", "Fill Text");
                          }
                        },
                        isNumber: true,
                        labeltext: translateDatabase("الخصم", "Descount"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                              textbutton: translateDatabase("تعديل", "Edit"),
                              onPressed: () {
                                if (formstateaddcate.currentState!.validate()) {
                                  if (selectedSize.id != null) {
                                    selectedSize.qty = count.text;
                                    selectedSize.price = price.text;
                                    selectedSize.descount = descount.text;
                                    size = selectedSize;
                                    Get.back();
                                  } else {
                                    // Get.snackbar(
                                    //     backgroundColor: Colors.red,
                                    //     translateDatabase("تنبية", "Alert"),
                                    //     translateDatabase("يرجى اختيار المقاس ",
                                    //         "Please Choose Size"));
                                  }
                                }
                              }),
                          CustomButton(
                              textbutton: translateDatabase("الغاء", "Cancel"),
                              onPressed: () {
                                selectedSize = SizeModel();
                                Get.back();
                              })
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
    return Future.value(size);
  }
}
