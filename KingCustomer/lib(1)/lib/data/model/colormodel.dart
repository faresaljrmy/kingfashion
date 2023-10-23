import 'package:kingfashion/data/model/sizemodel.dart';

class ColorModel {
  String? id;
  String? name;
  String? nameAr;
  String? userId;
  List<SizeModel>? sizes;
  String? rgb;
  bool isSelected = false;
  dynamic countSizes;
  String? dateTime;

  ColorModel(
      {this.id,
      this.name,
      this.nameAr,
      this.userId,
      this.sizes,
      this.rgb,
      isSelected,
      this.countSizes,
      this.dateTime});

  ColorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    rgb = json["rgb"];
    userId = json['usr_id'];
    dateTime = json['datetime'];
  }
  ColorModel.fromJsonItem(Map<String, dynamic> json) {
    // if (json['sizes'] != null) {
    //   sizes = [];
    //   json['sizes'].forEach((v) {
    //     sizes!.add(SizeModel.fromJsonColor(v));
    //   });
    // }
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    rgb = json['rgb'];
    countSizes = json["countsizes"];
    if (json['sizes'] != null) {
      sizes = <SizeModel>[];
      json['sizes'].forEach((v) {
        sizes!.add(SizeModel.fromJsonColor(v));
      });
    }
    // isSelected = json["isSelected"] ?? false;
    // if (json['sizes'] != null) {
    //   sizes = <SizeModel>[];
    //   json['sizes'].forEach((v) {
    //     sizes!.add(MySizes.fromJson(v));
    //   });
    // }
  }

  ColorModel.fromJsonCart(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    rgb = json["rgb"];
    if (json['sizes'] != null) {
      sizes = [];
      json['sizes'].forEach((v) {
        sizes!.add(SizeModel.fromJsonCartColor(v));
      });
    }
    // userId = json['usr_id'];
    // dateTime = json['datetime'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['namear'] = nameAr;
    // data['userid'] = myServices.sharedPreferences.getString("id");
    data['rgb'] = rgb;
    // if (sizes != null) {
    //   data['sizes'] = sizes!.map((v) => v.toMap()).toList();
    // }
    return data;
  }
}
