/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/material.dart';
import 'package:ruined_cars/api/addresses.dart';
import 'package:ruined_cars/models/car_manufacture.dart';
import 'package:ruined_cars/models/car_model.dart';

class CarModelProvider extends ChangeNotifier {
  CarModel selectedCarModel;
  CarManufacture selectedCarManufacture;

  List<CarModel> carsModel = [];
  List<CarManufacture> carsManufactures = [];

  CarModelProvider(var ctx) {
    getCarManufactures(ctx).then((value) {
      carsManufactures.addAll(value.model);
      notifyListeners();
    });
    getCarModels(ctx).then((value) {
      carsModel.addAll(value.model);
      notifyListeners();
    });
  }
  setCarModel(CarModel m) {
    selectedCarModel = m;
    notifyListeners();
  }

  setCarManufacture(CarManufacture m) {
    selectedCarManufacture = m;
    notifyListeners();
  }
}
