/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:ruined_cars/api/common.dart';
import 'package:ruined_cars/api/response.dart';
import 'package:ruined_cars/models/request_model.dart';
import 'package:ruined_cars/models/user_model.dart';

Future<ResponseApi> createRequest(
    {int model_id,
    int manuId,
    String ar_plateNum,
    String en_platNum,
    String plate_color,
    String color,
    String lat,
    String lng,
    int state_id,
    int city_id,
    String baladya,
    int area_id,
    int user_id,
    String orderType,
    String chassisValue,
    List<File> images}) async {
  var params = {
    'model_id': model_id.toString(),
    'plate_number': ar_plateNum,
    "en_platenum": en_platNum,
    "plate_color": plate_color,
    'color': color,
    'lat': lat,
    'longitude': lng,
    "man_id": manuId.toString(),
    'state': state_id.toString(),
    'baladya': baladya,
    'city': city_id.toString(),
    'area': area_id.toString(),
    'user': user_id.toString(),
    "chassis": chassisValue,
    "direct": orderType.toString()
  };

  var uri = Uri.parse(Common.baseUrl + "request/create.php");
  var request = MultipartRequest('POST', uri);
  request.fields.addAll(params);
  print('Fields:${request.fields}');
  print('ImagesLen:${images.length}');
  List<MultipartFile> parts = [];
  log("RequestParams:$params");
  await Future.forEach<File>(images, (element) async {
    print('EPath:${element.path}');
    String m = lookupMimeType(element.path);
    print('Typel:$m');
    var fileType = m.split('/');

    parts.add(MultipartFile.fromBytes(
        images.indexOf(element).toString(), await element.readAsBytes(),
        filename: element.path.split('/').last,
        contentType: MediaType(fileType[0], fileType[1])));
  });
  request.files.addAll(parts);
  log('filesLenFlutter:${request.files.length}');
  var response = await request.send();
  final respStr = await Response.fromStream(response);
  var json = jsonDecode(respStr.body);
  // if (json['success'] == 0&&json['message'].toString().contains("Duplicate entry")) {
  //   return ResponseApi(
  //     success: 0,
  //     message: 'السيارة مسجلة مسبقا'
  //   );
  // }
  print("resp:${respStr.body}");
  if (response.statusCode == 200) {}
}

Future<ResponseApi<List<RequestModel>>> getUserRequests(
    {String user_id}) async {
  var response = await post(Common.baseUrl + "request/get_user_request.php",
      body: {'user_id': user_id});

  //print("LoginResponse:${response.body}");
  List<RequestModel> cars = [];
  print("requests:${response.body}");
  //print("LoginResponse:${response.body}");
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    if (json['success'] == 1) {
      List data = json['data'];
      data.forEach((element) {
        cars.add(RequestModel.fromJson(element));
      });
    }

    return ResponseApi(
        message: json['message'],
        success: json['success'],
        model: (json['data'] == null) ? null : cars);
  }

  return ResponseApi(
      message: 'Error network connection', success: 0, model: cars);
}

Future<ResponseApi<List<String>>> getRequestImages({String request_id}) async {
  var response = await post(Common.baseUrl + "request/get_request_images.php",
      body: {'request_id': request_id});

  //print("LoginResponse:${response.body}");
  List<String> images = [];
  print("requestsImages:${response.body}");
  //print("LoginResponse:${response.body}");
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    if (json['success'] == 1) {
      List data = json['data'];
      data.forEach((element) {
        images.add(element['path']);
      });
    }

    return ResponseApi(
        message: json['message'],
        success: json['success'],
        model: (json['data'] == null) ? null : images);
  }

  return ResponseApi(
      message: 'Error network connection', success: 0, model: images);
}
