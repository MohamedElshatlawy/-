/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/material.dart';
import 'package:ruined_cars/api/addresses.dart';
import 'package:ruined_cars/models/new_area_model.dart';

class AreaProvider extends ChangeNotifier {
  NewAreaModel selectedAreaModel;

  List<NewAreaModel> areas = [];
  AreaProvider(var ctx) {
    getAreas(ctx).then((value) {
      areas.addAll(value.model);
      notifyListeners();
    });
  }
  setAreaModel(NewAreaModel m) {
    selectedAreaModel = m;
    //notifyListeners();
  }
}
