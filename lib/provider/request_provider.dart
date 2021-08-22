/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ruined_cars/models/new_area_model.dart';
import 'package:ruined_cars/models/new_city_model.dart';
import 'package:ruined_cars/models/new_state_model.dart';
import 'package:ruined_cars/models/request_model.dart';

class RequestProvider extends ChangeNotifier {
  NewCityModel selectedCityModel;
  NewStateModel selectedStateModel;
  NewAreaModel selectedAreaModel;

  RequestModel requestModel;

  void setModel(RequestModel rm) {
    requestModel = rm;
    //notifyListeners();
  }

  LatLng currentLocation;

  setStateModel(NewStateModel model) {
    selectedStateModel = model;
    notifyListeners();
  }

  setCityModel(NewCityModel model) {
    selectedCityModel = model;
    notifyListeners();
  }

  setAreaModel(NewAreaModel model) {
    selectedAreaModel = model;
    notifyListeners();
  }

  setCurrentLocation(LatLng location) {
    currentLocation = location;
    notifyListeners();
  }
}
