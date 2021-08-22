/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'dart:convert';

import 'package:http/http.dart';
import 'package:ruined_cars/api/common.dart';
import 'package:ruined_cars/api/response.dart';
import 'package:ruined_cars/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ResponseApi> login({String userName, String password}) async {
  var params = {'user_name': userName, 'password': password};
  print(params);
  var response = await post(Common.baseUrl + "user/login.php", body: params);

  print("LoginResponse:${response.body}");
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    print("JsonResponse:$json");
    return ResponseApi(
        message: json['message'],
        success: json['success'],
        model: (json['data'] == null) ? null : User.fromJson(json['data']));
  }
  throw 'حدث خطأ في الأتصال';
}

Future<void> saveUserSharedPrefrence(User user) async {
  var sh = await SharedPreferences.getInstance();
  sh.setString("username", user.userName);
  sh.setString("name", user.name);
  sh.setString("phone", user.phone);
  sh.setString("id", user.id);
  sh.setString("type_name", user.type_name);
  sh.setString("type_id", user.typeId);
  sh.setString("password", user.password);
}

Future<User> getUserSharedPrefrence() async {
  var sh = await SharedPreferences.getInstance();
  User user;
  if (sh.getString('username') != null) {
    user = User(
        id: sh.getString('id'),
        name: sh.getString('name'),
        phone: sh.getString('phone'),
        typeId: sh.getString('type_id'),
        userName: sh.getString('username'),
        type_name: sh.getString('type_name'));
  }
  return user;
}

logoutUserSharedPrefrence() async {
  var sh = await SharedPreferences.getInstance();
  sh.clear();
}
