/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/material.dart';
import 'package:ruined_cars/views/colors/mycolors.dart';
import 'package:ruined_cars/views/widgets/custom_btn.dart';
import 'package:ruined_cars/views/widgets/custom_textfield.dart';

class SupervisorAddUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'إضافة مستخدم',
          style: TextStyle(color: CustomColor.primary),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey)),
              child: DropdownButton<String>(
                  hint: Text('الصلاحيات'),
                  isExpanded: true,
                  underline: Container(),
                  items: List.generate(
                      3,
                      (index) => DropdownMenuItem(
                            child: Text('الوظيفة'),
                            value: index.toString(),
                          )),
                  onChanged: (v) {}),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 45,
              width: double.infinity,
              child: CustomButton(
                background: CustomColor.primary,
                foreground: Colors.white,
                text: 'إضافة',
                pressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
