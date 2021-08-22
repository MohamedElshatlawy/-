/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'point_model.dart';

class CarModel {
  String id;

  String manufacture_id;
  String name;
  String arName;

  CarModel({this.id, this.manufacture_id, this.name, this.arName});
  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    manufacture_id = json['manufacture_id'];

    name = json['name'].toString();
    arName = json['en_name'].toString();
  }
}
