import 'package:kingfashion/core/class/crud.dart';
import 'package:kingfashion/linkapi.dart';

class HomeAdminData {
  Crud crud;
  HomeAdminData(this.crud);
  getData() async {
    var response = await crud.postData(AppLink.homeadminpage, {});
    return response.fold((l) => l, (r) => r);
  }
}
