/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
class CarManufacture {
  String id;

  String name;
  String arName;

  CarManufacture({this.id, this.name, this.arName});
  CarManufacture.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'].toString();
    arName = json['ar_name'].toString();
  }
}
