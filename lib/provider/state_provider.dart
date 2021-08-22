/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/material.dart';
import 'package:ruined_cars/api/addresses.dart';
import 'package:ruined_cars/models/new_state_model.dart';

class StateProvider extends ChangeNotifier {
  NewStateModel selectedStateModel;

  List<NewStateModel> states = [];
  StateProvider(var ctx) {
    getStates(ctx).then((value) {
      states.addAll(value.model);
      setStateModel(states.firstWhere((element) => element.id == 13));
    });
  }
  void setStateModel(NewStateModel m) {
    selectedStateModel = m;
    print("StateID:${m.id}");
    print("CityName:${m.name}");

    notifyListeners();
  }
}
