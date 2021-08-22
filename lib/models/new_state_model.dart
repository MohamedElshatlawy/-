/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:ruined_cars/models/point_model.dart';

class NewStateModel {
  int id;
  int country_id;
  Point point;
  String name;
  NewStateModel();
  NewStateModel.fromJson(Map<String, dynamic> json) {
    id = json['attributes']['ID_Covernorate'];
    name = json['attributes']['Name_Covernorate'];
    country_id = json['attributes']['ID_Country'];
    point = Point(x: json['geometry']['y'], y: json['geometry']['x']);
  }
}
