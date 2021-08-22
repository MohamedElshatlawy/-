/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ruined_cars/api/response.dart';
import 'package:ruined_cars/models/car_manufacture.dart';
import 'package:ruined_cars/models/car_model.dart';
import 'package:ruined_cars/models/new_area_model.dart';
import 'package:ruined_cars/models/new_baladya.dart';
import 'package:ruined_cars/models/new_city_model.dart';
import 'package:ruined_cars/models/new_state_model.dart';

import 'common.dart';

Future<ResponseApi> getStates(var ctx) async {
  String data =
      await DefaultAssetBundle.of(ctx).loadString("assets/new_states.json");
  List jsonResult = json.decode(data);
  List<NewStateModel> states = [];
  jsonResult.forEach((element) {
    states.add(NewStateModel.fromJson(element));
  });
  return ResponseApi(message: null, success: 1, model: states);
}

Future<ResponseApi> getCities(var ctx) async {
  String data =
      await DefaultAssetBundle.of(ctx).loadString("assets/new_cities.json");
  List jsonResult = json.decode(data);
  List<NewCityModel> cities = [];
  jsonResult.forEach((element) {
    cities.add(NewCityModel.fromJson(element));
  });
  return ResponseApi(message: null, success: 1, model: cities);
}

Future<ResponseApi> getBaladya(var ctx) async {
  String data =
      await DefaultAssetBundle.of(ctx).loadString("assets/baladya.json");
  List jsonResult = json.decode(data);
  List<BaladyaModel> baladya = [];
  jsonResult.forEach((element) {
    baladya.add(BaladyaModel.fromJson(element));
  });
  return ResponseApi(message: null, success: 1, model: baladya);
}

Future<ResponseApi> getAreas(var ctx) async {
  String data =
      await DefaultAssetBundle.of(ctx).loadString("assets/madina_areas.json");
  List jsonResult = json.decode(data);
  List<NewAreaModel> areas = [];
  jsonResult.forEach((element) {
    areas.add(NewAreaModel.fromJson(element));
  });
  return ResponseApi(message: null, success: 1, model: areas);
}

Future<ResponseApi> getCarModels(var ctx) async {
  var response = await get(Common.baseUrl + "model/get_models.php");
  List<CarModel> models = [];
  print("Models:${response.body}");
  //print("LoginResponse:${response.body}");
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    if (json['success'] == 1) {
      List data = json['data'];
      data.forEach((element) {
        models.add(CarModel.fromJson(element));
      });
    }

    return ResponseApi(
        message: json['message'],
        success: json['success'],
        model: (json['data'] == null) ? null : models);
  }

  return ResponseApi(
      message: 'Error network connection', success: 0, model: models);
  // String data =
  //     await DefaultAssetBundle.of(ctx).loadString("assets/models1.json");
  // List jsonResult = json.decode(data);
  // List<CarModel> models = [];
  // jsonResult.forEach((element) {
  //   models.add(CarModel.fromJson(element));
  // });
  // return ResponseApi(message: null, success: 1, model: models);
}

Future<ResponseApi> getCarManufactures(var ctx) async {
  var response = await get(Common.baseUrl + "model/get_manufactures.php");
  List<CarManufacture> cars = [];
  print("Manufactures:${response.body}");
  //print("LoginResponse:${response.body}");
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    if (json['success'] == 1) {
      List data = json['data'];
      data.forEach((element) {
        cars.add(CarManufacture.fromJson(element));
      });
    }

    return ResponseApi(
        message: json['message'],
        success: json['success'],
        model: (json['data'] == null) ? null : cars);
  }

  return ResponseApi(
      message: 'Error network connection', success: 0, model: cars);
  // String data = await DefaultAssetBundle.of(ctx).loadString("assets/manu.json");
  // List jsonResult = json.decode(data);
  // List<CarManufacture> manus = [];
  // jsonResult.forEach((element) {
  //   manus.add(CarManufacture.fromJson(element));
  // });
  // return ResponseApi(message: null, success: 1, model: manus);
}
