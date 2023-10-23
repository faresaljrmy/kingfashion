// import 'package:kingfashion/data/model/colormodel.dart';

// class ItemModel {
//   List<ColorModel>? colors;
//   String? id;
//   String? name;
//   String? nameAr;
//   String? desc;
//   String? daescAr;
//   String? itemsImage;
//   String? itemsCount;
//   String? itemsActive;
//   String? itemsPrice;
//   String? itemsDiscount;
//   String? itemsDate;
//   String? itemsCat;
//   String? categoriesId;
//   String? categoriesName;
//   String? categoriesNamaAr;
//   String? categoriesImage;
//   String? categoriesDatetime;
//   String? favorite;
//   String? itemsPriceDiscount;
//   List<String>? listImage;

//   ItemModel(
//       {this.id,
//       this.name,
//       this.nameAr,
//       this.desc,
//       this.daescAr,
//       this.itemsImage,
//       this.itemsCount,
//       this.itemsActive,
//       this.itemsPrice,
//       this.itemsDiscount,
//       this.itemsDate,
//       this.itemsCat,
//       this.itemsPriceDiscount,
//       this.categoriesId,
//       this.categoriesName,
//       this.categoriesNamaAr,
//       this.categoriesImage,
//       this.categoriesDatetime,
//       this.favorite,
//       this.listImage,
//       this.colors});

//   ItemModel.fromJson(Map<String, dynamic> json) {
//     if (json['0'] != null) {
//       colors = [];
//       json['0'].forEach((v) {
//         colors!.add(ColorModel.fromJsonItem(v));
//       });
//     }
//     id = json['itm_id'];
//     name = json['itm_name'];
//     nameAr = json['itm_name_ar'];
//     desc = json['itm_desc'];
//     daescAr = json['itm_desc_ar'];
//     itemsImage = json['itm_image'];
//     itemsCount = json['itm_qty'];
//     itemsActive = json['itm_active'];
//     itemsPrice = json['itm_price'];
//     itemsDiscount = json['itm_descount'];
//     itemsDate = json['itm_datetime'];
//     itemsCat = json['itm_id'];
//     itemsPriceDiscount = json['itemspricedisount'];
//     categoriesId = json['id'];
//     categoriesName = json['cat_name'];
//     categoriesNamaAr = json['cat_nama_ar'];
//     categoriesImage = json['cat_image'];
//     categoriesDatetime = json['cat_datetime'];
//     favorite = json['favorite'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['itm_id'] = id;
//     data['itm_name'] = name;
//     data['itm_name_ar'] = nameAr;
//     data['itm_desc'] = desc;
//     data['itm_desc_ar'] = daescAr;
//     data['itm_image'] = itemsImage;
//     data['itm_qty'] = itemsCount;
//     data['itm_active'] = itemsActive;
//     data['itm_price'] = itemsPrice;
//     data['itm_descount'] = itemsDiscount;
//     data['itm_datetime'] = itemsDate;
//     data['itm_id'] = itemsCat;
//     data['id'] = categoriesId;
//     data['cat_name'] = categoriesName;
//     data['cat_nama_ar'] = categoriesNamaAr;
//     data['cat_image'] = categoriesImage;
//     data['cat_datetime'] = categoriesDatetime;
//     return data;
//   }
// }
