/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
class User {
  String _id;
  String _name;
  String _phone;
  String _typeId;
  String _userName;
  String type_name;
  String password;

  User({
    String id,
    String name,
    String phone,
    String typeId,
    String userName,
    this.password,
    this.type_name,
  }) {
    this._id = id;
    this._name = name;
    this._phone = phone;
    this._typeId = typeId;

    this._userName = userName;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get phone => _phone;
  set phone(String phone) => _phone = phone;
  String get typeId => _typeId;
  set typeId(String typeId) => _typeId = typeId;
  String get userName => _userName;
  set userName(String userName) => _userName = userName;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _phone = json['phone'];
    _typeId = json['type_id'];
    _userName = json['user_name'];
    type_name = json['type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['phone'] = this._phone;
    data['type_id'] = this._typeId;
    data['user_name'] = this._userName;
    return data;
  }
}
