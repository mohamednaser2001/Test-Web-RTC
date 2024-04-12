import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;



class Crud {

  Future<http.Response> postData({required String url, required Map data, String? token}) async {

    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    final response = await http.post(
      Uri.parse(url),
      body: data,
      headers: headers,
    );

    return response;
  }

Future<http.Response> getData(
    {required String url,
    required String token,
    bool isResponseList = false}) async {

      var headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };
      var response = await http.get(Uri.parse(url), headers: headers);

      return response;
}




  // Future<Either<StatusRequest, Map>> postDataJson(
  //     {required String linkurl, required Map data, String? token}) async {
  //   try {
  //     if (await checkInternet()) {
  //       var headers = {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json'
  //       };
  //
  //       var response = await http.post(
  //         Uri.parse(linkurl),
  //         body: jsonEncode(data),
  //         headers: headers,
  //       );
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         Map responsebody = jsonDecode(response.body);
  //
  //         return Right(responsebody);
  //       }
  //       if (response.statusCode == 404) {
  //         return const Left(StatusRequest.failure);
  //       }
  //       if (response.statusCode == 400) {
  //         return const Left(StatusRequest.failure);
  //       }
  //       if (response.statusCode == 425) {
  //         return const Left(StatusRequest.chatfound);
  //       }
  //       if (response.statusCode == 401) {
  //         return const Left(StatusRequest.failure);
  //       } else {
  //         return const Left(StatusRequest.serverfailure);
  //       }
  //     } else {
  //       return const Left(StatusRequest.offlinefailure);
  //     }
  //   } catch (e) {
  //     return const Left(StatusRequest.serverException);
  //   }
  // }
  //

  //
  // Future<Either<StatusRequest, Map>> getJsonData({
  //   required String linkurl,
  //   String? token,
  // }) async {
  //   try {
  //     if (await checkInternet()) {
  //       var headers = {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       };
  //       var response = await http.get(
  //         Uri.parse(linkurl),
  //         headers: headers,
  //       );
  //       print(jsonDecode(response.body));
  //       print(response.statusCode);
  //       print("--------------------------------");
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         Map responsebody = jsonDecode(response.body);
  //         return Right(responsebody);
  //       }
  //       if (response.statusCode == 404) {
  //         return const Left(StatusRequest.failure);
  //       }
  //       if (response.statusCode == 400) {
  //         return const Left(StatusRequest.failure);
  //       }
  //       if (response.statusCode == 401) {
  //         return const Left(StatusRequest.unauthorized);
  //       } else {
  //         return const Left(StatusRequest.serverfailure);
  //       }
  //     } else {
  //       return const Left(StatusRequest.offlinefailure);
  //     }
  //   } catch (e) {
  //     print(e);
  //     print('==================================');
  //     return const Left(StatusRequest.serverException);
  //   }
  // }
  //
  // Future<Either<StatusRequest, Map>> putData(
  //     {required String linkurl, required Map data, String? token}) async {
  //   try {
  //     if (await checkInternet()) {
  //       var headers = {
  //         'Authorization': 'Bearer $token',
  //         'Accept': 'application/json',
  //       };
  //       var response =
  //           await http.put(Uri.parse(linkurl), body: data, headers: headers);
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         Map responsebody = jsonDecode(response.body);
  //         return Right(responsebody);
  //       }
  //       if (response.statusCode == 404) {
  //         return const Left(StatusRequest.failure);
  //       }
  //       if (response.statusCode == 400) {
  //         return const Left(StatusRequest.failure);
  //       }
  //       if (response.statusCode == 401) {
  //         return const Left(StatusRequest.unauthorized);
  //       } else {
  //         return const Left(StatusRequest.serverfailure);
  //       }
  //     } else {
  //       return const Left(StatusRequest.offlinefailure);
  //     }
  //   } catch (e) {
  //     return const Left(StatusRequest.serverException);
  //   }
  // }
  //
  // Future<Either<StatusRequest, Map>> putDataJson(
  //     {required String linkurl, required Map data, String? token}) async {
  //   try {
  //     if (await checkInternet()) {
  //       var headers = {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json'
  //       };
  //       var response = await http.put(Uri.parse(linkurl),
  //           body: jsonEncode(data), headers: headers);
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         Map responsebody = jsonDecode(response.body);
  //         return Right(responsebody);
  //       }
  //       if (response.statusCode == 404) {
  //         return const Left(StatusRequest.failure);
  //       }
  //       if (response.statusCode == 400) {
  //         return const Left(StatusRequest.failure);
  //       }
  //       if (response.statusCode == 401) {
  //         return const Left(StatusRequest.unauthorized);
  //       } else {
  //         return const Left(StatusRequest.serverfailure);
  //       }
  //     } else {
  //       return const Left(StatusRequest.offlinefailure);
  //     }
  //   } catch (e) {
  //     return const Left(StatusRequest.offlinefailure);
  //   }
  // }
  //
  // Future<Either<StatusRequest, Map>> deleteData(
  //     {required String linkurl, Map? data, String? token}) async {
  //   try {
  //     if (await checkInternet()) {
  //       var headers = {
  //         'Authorization': 'Bearer $token',
  //         'Accept': 'application/json',
  //       };
  //       var response =
  //           await http.delete(Uri.parse(linkurl), body: data, headers: headers);
  //       print(jsonDecode(response.body));
  //       print('\\\\\\\\\\\\\\\\\\\\\\\\');
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         Map responsebody = jsonDecode(response.body);
  //         return Right(responsebody);
  //       }
  //       if (response.statusCode == 404) {
  //         return const Left(StatusRequest.failure);
  //       }
  //       if (response.statusCode == 400) {
  //         return const Left(StatusRequest.failure);
  //       }
  //       if (response.statusCode == 401) {
  //         return const Left(StatusRequest.unauthorized);
  //       } else {
  //         return const Left(StatusRequest.serverfailure);
  //       }
  //     } else {
  //       return const Left(StatusRequest.offlinefailure);
  //     }
  //   } catch (e) {
  //     print(e);
  //     print('sddddddddddddddddddddddddddddddddddddd');
  //     return const Left(StatusRequest.serverException);
  //   }
  // }
  //
  // Future<Either<StatusRequest, Map>> deleteJsonData(
  //     {required String linkurl,
  //     Map<dynamic, dynamic>? data,
  //     String? token}) async {
  //   try {
  //     if (await checkInternet()) {
  //       var headers = {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json'
  //       };
  //       var response = await http.delete(Uri.parse(linkurl),
  //           body: jsonEncode(data), headers: headers);
  //       print(jsonDecode(response.body));
  //       print('\\\\\\\\\\\\\\\\\\\\\\\\');
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         Map responsebody = jsonDecode(response.body);
  //         return Right(responsebody);
  //       }
  //       if (response.statusCode == 404) {
  //         return const Left(StatusRequest.failure);
  //       }
  //       if (response.statusCode == 400) {
  //         return const Left(StatusRequest.failure);
  //       }
  //       if (response.statusCode == 401) {
  //         return const Left(StatusRequest.unauthorized);
  //       } else {
  //         return const Left(StatusRequest.serverfailure);
  //       }
  //     } else {
  //       return const Left(StatusRequest.offlinefailure);
  //     }
  //   } catch (e) {
  //     return const Left(StatusRequest.serverException);
  //   }
  // }
  //
  // Future<Either<StatusRequest, Map>> postMultiPart(
  //     {required List<File> images,
  //     required String linkUrl,
  //     required String token,
  //     bool? isMultiImage,
  //     Map<String, String>? data}) async {
  //   try {
  //     if (await checkInternet()) {
  //       final Uri apiUrl = Uri.parse(linkUrl);
  //       Map<String, String> headers = {
  //         "Accept": "application/json",
  //         "Content-Type": "multipart/form-data",
  //         "Authorization": 'Bearer $token',
  //       };
  //
  //       final request = http.MultipartRequest('POST', apiUrl);
  //       request.headers.addAll(headers);
  //       if (isMultiImage == true) {
  //         List<http.MultipartFile> files = [];
  //         for (File image in images) {
  //           files
  //               .add(await http.MultipartFile.fromPath('images[]', image.path));
  //         }
  //         request.files.addAll(files);
  //       } else {
  //         request.files
  //             .add(await http.MultipartFile.fromPath('image', images[0].path));
  //       }
  //
  //       if (data != null) {
  //         request.fields.addAll(data);
  //       }
  //       final response = await request.send();
  //       final responseString = await response.stream.bytesToString();
  //       print(responseString);
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         //Map responseBody = jsonDecode(responseString);
  //         return Right(jsonDecode(responseString));
  //       }
  //
  //       if (response.statusCode == 404) {
  //         return const Left(StatusRequest.failure);
  //       }
  //       if (response.statusCode == 401) {
  //         return const Left(StatusRequest.unauthorized);
  //       }
  //       if (response.statusCode == 422) {
  //         return const Left(StatusRequest.invalidData);
  //       }
  //       if (response.statusCode == 400) {
  //         return const Left(StatusRequest.failure);
  //       } else {
  //         return const Left(StatusRequest.serverfailure);
  //       }
  //     } else {
  //       return const Left(StatusRequest.offlinefailure);
  //     }
  //   } catch (e) {
  //     return const Left(StatusRequest.serverException);
  //   }
  // }
}
