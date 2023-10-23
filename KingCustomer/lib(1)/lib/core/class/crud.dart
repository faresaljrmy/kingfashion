import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:kingfashion/core/class/statusrequest.dart';
import 'package:kingfashion/core/functions/checkinternet.dart';

String _basicAuth = 'basic ${base64Encode(utf8.encode('fares:faresking'))}';
Map<String, String> myheaders = {
  "authorization": _basicAuth,
  // 'Content-Type': 'application/json; charset=UTF-8',
  // 'Accept': "*/*",
  // 'connection': 'keep-alive',
  // 'Accept-Encoding': 'gzip, deflate, br',
};

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    if (await checkInternet()) {
      var response =
          await http.post(Uri.parse(linkurl), body: data, headers: myheaders);
      // print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(response.body);
        // print(responsebody);

        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Either<StatusRequest, Map>> postDataWithImage(
      String linkUrl, Map data, File image) async {
    if (await checkInternet()) {
      var request = http.MultipartRequest("POST", Uri.parse(linkUrl));
      var length = await image.length();
      var stream = http.ByteStream(image.openRead());
      var multipartPartFile = http.MultipartFile("files", stream, length,
          filename: basename(image.path));
      request.headers.addAll(myheaders);
      // request.Encoding = Utf8Codec();
      request.files.add(multipartPartFile);
      data.forEach((key, value) {
        request.fields[key] = value;
      });
      var myRequest = await request.send();
      var response = await http.Response.fromStream(myRequest);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("===${response.body}==============================");

        Map responsebody = jsonDecode(response.body);
        print(responsebody);

        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
}
