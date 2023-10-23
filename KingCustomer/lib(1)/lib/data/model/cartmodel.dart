import 'package:kingfashion/data/model/colormodel.dart';

class CartModel {
  String? totalPrice;
  String? countitems;
  String? itemsId;
  String? itemsName;
  String? itemsNameAr;
  String? itemsDesc;
  String? itemsDescAr;
  String? itemsImage;
  String? orderid;
  String? status;
  String? date;
  String? countcolor;
  String? countSize;
  List<ColorModel>? listColor;
  List<dynamic>? listitemImages;
  // String? countsize;
  // String? totalprice;

  String? itemsActive;
  String? itemsPrice;
  String? itemsDiscount;

  String? itemsCat;

  dynamic cartId;
  dynamic cartUsersid;
  dynamic cartItemsid;
  dynamic clrid;
  dynamic sizeId;
  dynamic sizeqty;
  dynamic price;
  dynamic descount;
  // SizeModel? sizeModel;

  CartModel(
      {this.totalPrice,
      this.countitems,
      this.cartId,
      this.cartUsersid,
      this.cartItemsid,
      this.itemsId,
      this.itemsName,
      this.itemsNameAr,
      this.itemsDesc,
      this.itemsDescAr,
      this.itemsImage,
      this.orderid,
      this.status,
      this.countcolor,
      this.countSize,
      this.itemsActive,
      this.itemsPrice,
      this.itemsDiscount,
      this.date,
      this.itemsCat,
      this.clrid,
      this.sizeId,
      this.price,
      this.sizeqty,
      this.descount,
      this.listColor,
      this.listitemImages});

  CartModel.fromJson(Map<String, dynamic> json) {
    // countitems = json['countitems'];
    cartId = json['cart_id'];
    cartUsersid = json['usr_id'];
    // cartItemsid = json['cart_itm'];
    itemsId = json['itm_id'];
    itemsName = json['itm_name'];
    itemsNameAr = json['itm_name_ar'];
    itemsDesc = json['itm_desc'];
    itemsDescAr = json['itm_desc_ar'];
    itemsImage = json['itm_image'];
    orderid = json["order_id"];
    status = json["status"];
    countSize = json['countsize'];
    countcolor = json['countcolor'];
    totalPrice = json['totalprice'];
    date = json['date'];
    listitemImages = json["allimages"] ?? [];
    if (json["colors"] != null) {
      listColor = [];
      json["colors"].forEach((v) {
        listColor!.add(ColorModel.fromJsonCart(v));
      });
    }
    // itemsActive = json['itm_active'];
    // itemsPrice = json['itm_price'];
    // itemsDiscount = json['itm_descount'];
    // itemsCat = json['itm_id'];
  }

  Map<String, dynamic> toJsonAdd() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = cartId ?? "";
    data["itmid"] = cartItemsid.toString();
    data["clrid"] = clrid.toString();
    data["sizid"] = sizeId.toString();
    data["qty"] = sizeqty.toString();
    data["price"] = price.toString();
    data["descount"] = descount.toString();
    data["userid"] = cartUsersid.toString();
    // print("toJsonAdd=================$data=========================");
    return data;
  }

  Map<String, dynamic> toJsonDelete() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["cartid"] = cartId;
    data["itmid"] = cartItemsid.toString();
    data["clrid"] = clrid.toString();
    data["sizid"] = sizeId.toString();
    data["userid"] = cartUsersid.toString();
    data["qty"] = sizeqty.toString();
    return data;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['itemsprice'] = itemsprice;
  //   data['countitems'] = countitems;
  //   data['cart_id'] = cartId;
  //   data['cart_usr'] = cartUsersid;
  //   data['cart_itm'] = cartItemsid;
  //   data['itm_id'] = itemsId;
  //   data['itm_name'] = itemsName;
  //   data['itm_name_ar'] = itemsNameAr;
  //   data['itm_desc'] = itemsDesc;
  //   data['itm_desc_ar'] = itemsDescAr;
  //   data['itm_image'] = itemsImage;
  //   data['itm_qty'] = itemsCount;
  //   data['itm_active'] = itemsActive;
  //   data['itm_price'] = itemsPrice;
  //   data['itm_descount'] = itemsDiscount;
  //   data['itm_datetime'] = itemsDate;
  //   data['itm_id'] = itemsCat;
  //   return data;
  // }
}
