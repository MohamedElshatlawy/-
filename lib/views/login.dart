/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ruined_cars/api/auth.dart';
import 'package:ruined_cars/models/user_model.dart';
import 'package:ruined_cars/others/Locale/appLocalization.dart';
import 'package:ruined_cars/others/Locale/localizationProvider.dart';
import 'package:ruined_cars/provider/user_provider.dart';
import 'package:ruined_cars/views/colors/mycolors.dart';
import 'package:ruined_cars/views/widgets/custom_btn.dart';
import 'package:ruined_cars/views/widgets/custom_progress.dart';
import 'package:ruined_cars/views/widgets/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  var userNameController = TextEditingController();
  var passController = TextEditingController();
  var loginKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);

    return Scaffold(
      key: loginKey,
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .18,
                ),
                Center(
                  child: Image.asset(
                    'assets/logo.png',
                    scale: 4,
                  ),
                ),

                CustomTextField(
                  hint: local.translate('login_name'),
                  controller: userNameController,
                ),
                SizedBox(
                  height: 13,
                ),
                CustomTextField(
                  hint: local.translate('login_pass'),
                  isPassword: true,
                  controller: passController,
                ),
                // SizedBox(
                //   height: 15,
                // ),
                // Row(
                //   children: [
                //     InkWell(
                //       child: Text(
                //         'نسيت كلمة المرور ؟',
                //         style:
                //             TextStyle(color: CustomColor.lightGreen, fontSize: 16),
                //       ),
                //     )
                //   ],
                // ),

                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  height: 48,
                  child: CustomButton(
                    background: CustomColor.green2,
                    foreground: Colors.white,
                    text: local.translate('login_btn'),
                    pressed: () async {
                      showCustomDialog(
                          context: context,
                          msg: local.translate('login_loading'));
                      await login(
                              userName: userNameController.text,
                              password: passController.text)
                          .whenComplete(() {
                        dismissCustomDialog(context: context);
                      }).then((value) {
                        if (value.success == 0) {
                          loginKey.currentState.showSnackBar(
                              SnackBar(content: Text(value.message)));
                        } else {
                          var userProvider =
                              Provider.of<UserProvider>(context, listen: false);
                          userProvider.setUser(value.model);
                          saveUserSharedPrefrence(value.model);
                          Navigator.pushReplacementNamed(context, '/emp_home');
                          // if (userProvider.user.typeId == "2") {
                          //   value.model.password = passController.text;
                          //   saveUserSharedPrefrence(value.model);
                          //   Navigator.pushReplacementNamed(
                          //       context, '/emp_home');
                          // } else {
                          //   loginKey.currentState.showSnackBar(SnackBar(
                          //       content:
                          //           Text("هذا المستخدم غير مصرح له بالدخول")));
                          // }
                        }
                      }).catchError((e) {
                        print("ErrorLogin:$e");
                        loginKey.currentState.showSnackBar(
                            SnackBar(content: Text('حدث خطأ في الإتصال')));
                      });
                      //  Navigator.pushReplacementNamed(context, '/emp_home');
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // InkWell(
                //   onTap: () {
                //     Navigator.pushNamed(context, '/register');
                //   },
                //   child: Text(
                //     'لا تمتلك حساب ؟ سجل الان',
                //     style: TextStyle(
                //         decoration: TextDecoration.underline,
                //         color: CustomColor.lightGreen,
                //         fontSize: 16),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
