/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/material.dart';
import 'package:ruined_cars/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User user;

  void setUser(User user) {
    this.user = user;
    notifyListeners();
  }
}
