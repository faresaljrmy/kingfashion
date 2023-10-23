import 'package:kingfashion/core/class/crud.dart';
import 'package:kingfashion/linkapi.dart';

class MyFavoriteData {
  Crud crud;
  MyFavoriteData(this.crud);
  getData(String id) async {
    var response = await crud.postData(AppLink.favoriteView, {"userid": id});
    return response.fold((l) => l, (r) => r);
  }

  deleteData(String id) async {
    var response = await crud.postData(AppLink.deletemyfavorite, {"id": id});
    return response.fold((l) => l, (r) => r);
  }
}
