/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:ruined_cars/api/response.dart';
import 'package:ruined_cars/models/request_model.dart';

Future<ResponseApi<List<RequestModel>>> search(
    {String plateNumber, String orderNumber, bool isChassis = false}) async {
  //print(params);
  Response response;
  if (plateNumber != null && !isChassis) {
    log("Chassis is false,LengPla:${plateNumber.trim().length}");
    response = await get(
        "http://alsaifit.com/cars/vendor/api/apisearch.php?plate_number=${plateNumber}");
  } else if (isChassis) {
    log("Chassis is true");
    response = await get(
        "http://alsaifit.com/cars/vendor/api/apisearch.php?chassis_number=$plateNumber");
  } else {
    log("OrderNumber:");

    response = await get(
        "http://alsaifit.com/cars/vendor/api/apisearch.php?order_number=$orderNumber");
  }

  String newResponse = Utf8Codec().decode(response.bodyBytes);
  log(newResponse);
  RequestModel requestModel;
  log("SearchResponse:$newResponse");
  if (response.statusCode == 200) {
    List json = jsonDecode(newResponse);
    List<RequestModel> searchModels = [];
    json.forEach((element) {
      searchModels.add(RequestModel.fromJson(element));
    });

    return ResponseApi(message: "success", success: 1, model: searchModels);
  }
  throw 'حدث خطأ في الأتصال';
}
