class SizeModel {
  dynamic id;
  dynamic name;
  dynamic namear;
  dynamic symbol;
  dynamic qty;
  dynamic price;
  dynamic descount;
  String? userid;
  String? dateTime;
  dynamic qtycart;
  dynamic saleQty;
  dynamic totalQty;
  bool? isSelected = false;

  SizeModel(
      {this.id,
      this.name,
      this.namear,
      this.symbol,
      this.qty,
      this.price,
      this.descount,
      this.userid,
      this.dateTime,
      this.qtycart,
      this.isSelected,
      this.saleQty,
      this.totalQty});

  SizeModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    namear = json["name_ar"];
    userid = json["siz_usr_id"];
    dateTime = json["siz_datetime"];
  }
  SizeModel.fromJsonColor(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    namear = json["name_ar"];
    symbol = json['symbol'];
    qty = json['qty'];
    qtycart = json["qty_cart"];
    price = json["price"];
    descount = json["descount"];
  }
  SizeModel.fromJsonCartColor(Map<String, dynamic> json) {
    id = json["size_id"];
    name = json["name"];
    namear = json["name_ar"];
    symbol = json['symbol'];
    qtycart = json['qty'];
    price = json["price"];
    descount = json["descount"];
    dateTime = json["date"];
    userid = json["usr_id"];
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "namear": namear,
      // "siz_usr_id": userid,
      // "siz_datetime":dateTime,
      // "quantity": quantity,
      // "saleQty": saleQty,
      // "totalQty": totalQty,
      // "isSelected": isSelected
    };
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      "id": id,
      "name": name,
      "namear": namear,
      "userid": userid,
      // "siz_datetime":dateTime,
      // "quantity": quantity,
      // "saleQty": saleQty,
      // "totalQty": totalQty,
      // "isSelected": isSelected
    };
  }
}
