/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'dart:convert';

import 'package:http/http.dart';
import 'package:ruined_cars/api/common.dart';
import 'package:ruined_cars/api/response.dart';
import 'package:ruined_cars/models/request_model.dart';

class CommentModel {
  String _id;
  String _name;
  String _description;
  String _userType;

  CommentModel({String id, String name, String description, String userType}) {
    this._id = id;
    this._name = name;
    this._description = description;
    this._userType = userType;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get description => _description;
  set description(String description) => _description = description;
  String get userType => _userType;
  set userType(String userType) => _userType = userType;

  CommentModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['description'] = this._description;
    data['user_type'] = this._userType;
    return data;
  }
}

Future<ResponseApi<List<CommentModel>>> getRequestComments(
    {String request_id}) async {
  print("Request:$request_id");

  var response = await get(
      "http://alsaifit.com/cars/vendor/api/apicomments.php?n=$request_id");

  List<CommentModel> comments = [];
  String newResponse = Utf8Codec().decode(response.bodyBytes);
  print("NewResponse:$newResponse");
  if (response.statusCode == 200) {
    List data = jsonDecode(newResponse);

    // List data = json['data'];
    data.forEach((element) {
      comments.add(CommentModel.fromJson(element));
    });

    return ResponseApi(success: 1, model: comments);
  }

  return ResponseApi(
      message: 'Error network connection', success: 0, model: comments);
}
