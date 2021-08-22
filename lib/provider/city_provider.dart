/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/material.dart';
import 'package:ruined_cars/api/addresses.dart';
import 'package:ruined_cars/models/new_city_model.dart';

class CityProvider extends ChangeNotifier {
  NewCityModel selectedCityModel;

  List<NewCityModel> cities = [];
  CityProvider(var ctx) {
    getCities(ctx).then((value) {
      cities.addAll(value.model);
      notifyListeners();
    });
  }
  setCityModel(NewCityModel m) {
    selectedCityModel = m;
    //notifyListeners();
  }
}
