import 'package:adminkingfashion/core/class/curd.dart';
import 'package:adminkingfashion/linkapi.dart';

class CheckEmailDataRemote {
  Crud crud;
  CheckEmailDataRemote(this.crud);

  postData(String email) async {
    var response = await crud.postData(AppLink.checkEmail, {
      "email": email,
    });
    return response.fold((l) => l, (r) => r);
  }
}
