import 'package:adminkingfashion/core/class/curd.dart';
import 'package:adminkingfashion/linkapi.dart';

class SignupDataRemote {
  Crud crud;
  SignupDataRemote(this.crud);

  postData(String username, String password, String email, String phone) async {
    var response = await crud.postData(AppLink.signUp, {
      "name": username,
      "password": password,
      "email": email,
      "phone": phone
    });
    return response.fold((l) => l, (r) => r);
  }
}
