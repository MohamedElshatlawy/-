/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:ruined_cars/models/point_model.dart';

class NewCityModel {
  int id;
  int state_id;
  int country_id;
  String name;
  Point point;
  NewCityModel();
  NewCityModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    name = json['NAME'];
    country_id = json['ID_Country'];
    state_id = json['STATE_ID'];
    point = Point(x: json['LAT'], y: json['LNG']);
  }
}
