import 'package:adminkingfashion/core/class/curd.dart';
import 'package:adminkingfashion/data/model/colormodel.dart';
import 'package:adminkingfashion/linkapi.dart';

class ColorsData {
  Crud crud;
  ColorsData(this.crud);
  getColors() async {
    var response = await crud.postData(AppLink.colorViewPage, {});
    return response.fold((l) => l, (r) => r);
  }

  addColor(ColorModel clrModel) async {
    var response =
        await crud.postData(AppLink.colorAddPage, clrModel.toJsonAdd());
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
