/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
class RequestModel {
  String _id;
  String _modelId;
  String _plateNumber;
  String _color;
  String _lat;
  String _lng;
  String _stateId;
  String _cityId;
  String _areaId;
  String _userId;
  String _createdAt;
  String _statusId;
  String status_name;
  String enPlateNumber;
  String plate_color;
  String chassis;
  String reason;
  List<String> imgPaths = [];

  RequestModel(
      {String id,
      String modelId,
      String plateNumber,
      String color,
      String lat,
      String lng,
      String stateId,
      String cityId,
      String areaId,
      String userId,
      String createdAt,
      String reason,
      this.enPlateNumber,
      this.plate_color,
      this.chassis,
      String statusId}) {
    this._id = id;
    this._modelId = modelId;
    this._plateNumber = plateNumber;
    this._color = color;
    this._lat = lat;
    this._lng = lng;
    this.reason = reason;
    this._stateId = stateId;
    this._cityId = cityId;
    this._areaId = areaId;
    this._userId = userId;
    this._createdAt = createdAt;
    this._statusId = statusId;
    this.imgPaths = imgPaths;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get modelId => _modelId;
  set modelId(String modelId) => _modelId = modelId;
  String get plateNumber => _plateNumber;
  set plateNumber(String plateNumber) => _plateNumber = plateNumber;
  String get color => _color;
  set color(String color) => _color = color;
  String get lat => _lat;
  set lat(String lat) => _lat = lat;
  String get lng => _lng;
  set lng(String lng) => _lng = lng;
  String get stateId => _stateId;
  set stateId(String stateId) => _stateId = stateId;
  String get cityId => _cityId;
  set cityId(String cityId) => _cityId = cityId;
  String get areaId => _areaId;
  set areaId(String areaId) => _areaId = areaId;
  String get userId => _userId;
  set userId(String userId) => _userId = userId;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get statusId => _statusId;
  set statusId(String statusId) => _statusId = statusId;

  RequestModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'].toString();
    _modelId = json['model_id'];
    _plateNumber = json['plate_number'];
    _color = json['color'];
    _lat = json['lat'];
    _lng = json['lng'];
    reason = json['reason'];
    _stateId = json['state_id'];
    _cityId = json['city_id'];
    _areaId = json['area_id'];
    _userId = json['user_id'];
    _createdAt = json['created_at'];
    _statusId = json['status_id'];
    status_name = json['status_name'];
    enPlateNumber = json['en_plate_number'] ?? json['enPlateNumber'];
    plate_color = json['plate_color'];
    chassis = json['chassis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this._id;
    data['model_id'] = this._modelId;
    data['plate_number'] = this._plateNumber;
    data['enPlateNumber'] = this.enPlateNumber;

    data['color'] = this._color;
    data['lat'] = this._lat;
    data['lng'] = this._lng;
    data['state_id'] = this._stateId;
    data['city_id'] = this._cityId;
    data['area_id'] = this._areaId;
    data['user_id'] = this._userId;
    // data['created_at'] = this._createdAt;
    data['plate_color'] = this.plate_color;
    data['chassis'] = this.chassis;

    //  data['status_id'] = this._statusId;
    return data;
  }
}
