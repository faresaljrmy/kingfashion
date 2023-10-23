import 'dart:io';
import 'package:kingfashion/linkapi.dart';
import 'package:kingfashion/core/class/crud.dart';

class SignupData {
  Crud crud;
  SignupData(this.crud);
  postdata(String username, String email, String shop, String address,
      String phone, String password) async {
    var response = await crud.postData(AppLink.signUp, {
      "name": username,
      "email": email,
      "shop": shop,
      "address": address,
      "phone": phone,
      "password": password,
      // "file":null
    });
    return response.fold((l) => l, (r) => r);
  }

  postDataWithImage(String username, String email, String shop, String address,
      String phone, String password, File image) async {
    Map<dynamic, dynamic> map = {
      "username": username,
      "email": email,
      "shop": shop,
      "address": address,
      "phone": phone,
      "password": password,
    };
    var response = await crud.postDataWithImage(AppLink.signUp, map, image);
    return response.fold((l) => l, (r) => r);
  }
}
