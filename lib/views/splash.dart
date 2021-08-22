/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:ruined_cars/api/auth.dart';
import 'package:ruined_cars/provider/user_provider.dart';
import 'package:ruined_cars/views/colors/mycolors.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    post(Uri.parse('https://api.leenalkhair.com/api/driver/login'),
            headers: {"accept": "Application/json"},
            body: {"email": "driver@gmail.com", "password": "123456"})
        .then((value) {
      log("then:${value.body}");
    }).catchError((e) {
      log("ErrorLogin:$e");
    });

    Future.delayed(Duration(seconds: 3), () {
      getUserSharedPrefrence().then((value) {
        if (value != null) {
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(value);
          Navigator.pushReplacementNamed(context, '/emp_home');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Stack(
        children: [
          Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/logo.png',
                scale: 4,
              ),
              //Text('السيارات الخربة')
            ],
          )),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/alsaif.png',
                    scale: 35,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Powered By'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
