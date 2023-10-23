import 'package:kingfashion/core/class/crud.dart';
import 'package:kingfashion/data/model/colormodel.dart';
import 'package:kingfashion/linkapi.dart';

class ColorsData {
  Crud crud;
  ColorsData(this.crud);
  getColors() async {
    var response = await crud.postData(AppLink.colorViewPage, {});
    return response.fold((l) => l, (r) => r);
  }

  addColor(ColorModel clrModel) async {
    var response = await crud.postData(AppLink.colorAddPage, clrModel.toJson());
    return response.fold((l) => l, (r) => r);
  }

  // Colors
  editColor(ColorModel clrModel) async {
    var response =
        await crud.postData(AppLink.colorEditPage, clrModel.toJson());
    return response.fold((l) => l, (r) => r);
  }

  deleteColor(String clrId) async {
    var response = await crud.postData(AppLink.colorDeletePage, {"id": clrId});
    return response.fold((l) => l, (r) => r);
  }
}
