import 'package:kingfashion/core/class/crud.dart';
import 'package:kingfashion/data/model/cartmodel.dart';
import 'package:kingfashion/linkapi.dart';

class ProductDetailsData {
  Crud crud;
  ProductDetailsData(this.crud);
  addCart(CartModel cartModel) async {
    var response = await crud.postData(AppLink.cartadd, cartModel.toJsonAdd());
    return response.fold((l) => l, (r) => r);
  }

  deleteCart(CartModel cartModel) async {
    var response =
        await crud.postData(AppLink.cartdelete, cartModel.toJsonDelete());
    return response.fold((l) => l, (r) => r);
  }

  getColorsItems(String userid, String itemsid) async {
    var response = await crud.postData(
        AppLink.detailsgetcolorsitem, {"userid": userid, "itmid": itemsid});
    return response.fold((l) => l, (r) => r);
  }
}
