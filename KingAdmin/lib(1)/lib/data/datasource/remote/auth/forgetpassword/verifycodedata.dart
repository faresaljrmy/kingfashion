import 'package:adminkingfashion/core/class/curd.dart';
import 'package:adminkingfashion/linkapi.dart';

class VerifyCodeDataRemote {
  Crud crud;
  VerifyCodeDataRemote(this.crud);

  postData(String email, String verifycode) async {
    var response = await crud.postData(AppLink.verifycodeforgetpassword, {
      "email": email,
      "verifycode": verifycode,
    });
    return response.fold((l) => l, (r) => r);
  }
}
