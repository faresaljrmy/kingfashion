import 'package:adminkingfashion/core/class/curd.dart';
import 'package:adminkingfashion/data/model/sizemodel.dart';
import 'package:adminkingfashion/linkapi.dart';

class SizesData {
  Crud crud;
  SizesData(this.crud);
  getSizes() async {
    var response = await crud.postData(AppLink.sizeViewPage, {});
    return response.fold((l) => l, (r) => r);
  }

  addSize(SizeModel sizModel) async {
    var response =
        await crud.postData(AppLink.sizeAddPage, sizModel.toJsonAdd());
    return response.fold((l) => l, (r) => r);
  }

  // Sizes
  editSize(SizeModel sizModel) async {
    var response = await crud.postData(AppLink.sizeEditPage, sizModel.toJson());
    return response.fold((l) => l, (r) => r);
  }

  deleteSize(String sizId) async {
    var response = await crud.postData(AppLink.sizeDeletePage, {"id": sizId});
    return response.fold((l) => l, (r) => r);
  }
}
