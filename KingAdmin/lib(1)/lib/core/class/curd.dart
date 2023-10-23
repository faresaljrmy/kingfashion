// ignore: depend_on_referenced_packages
import 'dart:convert';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/funcations/checkinternet.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(Uri.parse(linkurl), body: data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);

          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverfailure);
    }
  }

  Future<Either<StatusRequest, Map>> addRequestwithFiles(
      String linkurl, Map data, File? file,
      [String? namerequest]) async {
    namerequest ??= "files";
    var uri = Uri.parse(linkurl);
    var request = http.MultipartRequest("POST", uri);
    //  request.headers.addAll(_myheaders);

    if (file != null) {
      var length = await file.length();
      var stream = http.ByteStream(file.openRead());
      stream.cast();
      var multipartFile = http.MultipartFile(namerequest, stream, length,
          filename: basename(file.path));
      request.files.add(multipartFile);
    }

    // add Data to Request
    data.forEach((key, value) {
      request.fields[key] = value;
    });

    // send Request
    var myrequest = await request.send();

    // For get Response body
    var response = await http.Response.fromStream(myrequest);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map responsebody = jsonDecode(response.body);
      return Right(responsebody);
    } else {
      return const Left(StatusRequest.serverfailure);
    }
  }
}
