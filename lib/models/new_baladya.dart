/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
class BaladyaModel {
  String id;
  String name;
  String lat;
  String lng;

  BaladyaModel({this.id, this.name, this.lat, this.lng});

  BaladyaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
