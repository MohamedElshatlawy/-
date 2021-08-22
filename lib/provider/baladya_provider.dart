/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/material.dart';
import 'package:ruined_cars/api/addresses.dart';
import 'package:ruined_cars/models/new_baladya.dart';
import 'package:ruined_cars/models/new_city_model.dart';

class BaladyaProvider extends ChangeNotifier {
  BaladyaModel selectedBaladyaModel;

  List<BaladyaModel> baladya = [];
  BaladyaProvider(var ctx) {
    getBaladya(ctx).then((value) {
      baladya.addAll(value.model);
      notifyListeners();
    });
  }
  setBaladyaModel(BaladyaModel m) {
    selectedBaladyaModel = m;
    //notifyListeners();
  }
}
