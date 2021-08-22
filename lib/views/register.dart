/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ruined_cars/views/widgets/custom_btn.dart';
import 'package:ruined_cars/views/widgets/custom_textfield.dart';

import 'colors/mycolors.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 25,
                color: CustomColor.primary,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          SizedBox(
            width: 10,
          ),
        ],
        centerTitle: true,
        title: Text(
          'تسجيل حساب جديد',
          style: TextStyle(color: CustomColor.primary),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/winch.jpg',
                  scale: 2.2,
                ),
              ),
              CustomTextField(
                hint: 'الأسم الأول',
                isNumber: true,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                hint: 'اسم العائلة',
                isNumber: true,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                hint: 'رقم الهوية',
                isNumber: true,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                hint: 'رقم الجوال',
                isNumber: true,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                hint: 'البريد الإلكتروني',
                isNumber: true,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                hint: 'كلمة المرور',
                isPassword: true,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                hint: 'تأكيد كلمةالمرور',
                isPassword: true,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 48,
                child: CustomButton(
                  background: CustomColor.primary,
                  foreground: Colors.white,
                  text: 'تسجيل',
                  pressed: () {
                    Navigator.pushNamed(context, '/supervisor_home');
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
