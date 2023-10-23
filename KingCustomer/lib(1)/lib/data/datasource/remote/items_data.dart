import 'package:kingfashion/core/class/crud.dart';
import 'package:kingfashion/linkapi.dart';

class ItemsData {
  Crud crud;
  ItemsData(this.crud);
  getData(String id, String userid) async {
    var response = await crud
        .postData(AppLink.items, {"catid": id.toString(), "userid": userid});
    return response.fold((l) => l, (r) => r);
  }

  getImagesItem(String itemid) async {
    var response = await crud.postData(AppLink.imagesitems, {
      "id": itemid,
    });
    return response.fold((l) => l, (r) => r);
  }
}
