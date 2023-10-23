class MyFavoriteModel {
  String? favoriteId;
  String? favoriteUsersid;
  String? favoriteItemsid;
  String? itemsId;
  String? itemsName;
  String? itemsNameAr;
  String? itemsDesc;
  String? itemsDescAr;
  String? itemsImage;
  String? itemsCount;
  String? itemsActive;
  String? itemsPrice;
  String? itemsDiscount;
  String? itemsDate;
  String? itemsCat;
  String? usersId;

  MyFavoriteModel(
      {this.favoriteId,
      this.favoriteUsersid,
      this.favoriteItemsid,
      this.itemsId,
      this.itemsName,
      this.itemsNameAr,
      this.itemsDesc,
      this.itemsDescAr,
      this.itemsImage,
      this.itemsCount,
      this.itemsActive,
      this.itemsPrice,
      this.itemsDiscount,
      this.itemsDate,
      this.itemsCat,
      this.usersId});

  MyFavoriteModel.fromJson(Map<String, dynamic> json) {
    favoriteId = json['fav_id'];
    favoriteUsersid = json['fav_usr_id'];
    // favoriteItemsid = json['fav_itm_id'];
    itemsId = json['itm_id'];
    itemsName = json['itm_name'];
    itemsNameAr = json['itm_name_ar'];
    itemsDesc = json['itm_descr'];
    itemsDescAr = json['itm_descr_ar'];
    itemsImage = json['itm_image'];
    // itemsCount = json['itm_qty'];
    itemsActive = json['itm_active'];
    itemsPrice = json['itm_price'];
    itemsDiscount = json['itm_descount'];
    itemsDate = json['itm_date'];
    itemsCat = json['cat_id'];
    // usersId = json['usr_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fav_id'] = favoriteId;
    data['fav_usr_id'] = favoriteUsersid;
    data['fav_itm_id'] = favoriteItemsid;
    data['itm_id'] = itemsId;
    data['itm_name'] = itemsName;
    data['itm_name_ar'] = itemsNameAr;
    data['itm_desc'] = itemsDesc;
    data['itm_desc_ar'] = itemsDescAr;
    data['itm_image'] = itemsImage;
    data['itm_qty'] = itemsCount;
    data['itm_active'] = itemsActive;
    data['itm_price'] = itemsPrice;
    data['itm_descount'] = itemsDiscount;
    data['itm_datetime'] = itemsDate;
    data['itm_id'] = itemsCat;
    data['usr_id'] = usersId;
    return data;
  }
}
