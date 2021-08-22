/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'point_model.dart';

class NewAreaModel {
  int id;
  int country_id;
  int state_id;
  int city_id;
  String name;
  Point point;
  int baladya_id;
  NewAreaModel(
      {this.city_id,
      this.country_id,
      this.id,
      this.name,
      this.point,
      this.state_id});
  NewAreaModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['ID']);
    // country_id = json['COUNTRY_ID'];
    state_id = int.parse(json['STATE_ID']);
    city_id = int.parse(json['CITY_ID']);
    baladya_id = int.parse(json['baladya_id']);

    name = json['NAME'].toString();

    point = Point(x: double.parse(json['LAT']), y: double.parse(json['LNG']));
  }
}
