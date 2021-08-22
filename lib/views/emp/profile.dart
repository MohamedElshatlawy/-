/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ruined_cars/provider/user_provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('الحساب الشخصي'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Column(
          children: [
            Icon(
              Icons.person_pin,
              size: 150,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey)),
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    labelText: 'الإسم',
                    border: InputBorder.none),
                enabled: false,
                controller: TextEditingController(text: userProvider.user.name),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey)),
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    labelText: 'رقم الجوال',
                    border: InputBorder.none),
                enabled: false,
                controller:
                    TextEditingController(text: userProvider.user.phone),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey)),
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    labelText: 'اسم المستخدم',
                    border: InputBorder.none),
                enabled: false,
                controller:
                    TextEditingController(text: userProvider.user.userName),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey)),
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    labelText: 'نوع المستخدم',
                    border: InputBorder.none),
                enabled: false,
                controller:
                    TextEditingController(text: userProvider.user.type_name),
              ),
            )
          ],
        ),
      ),
    );
  }
}
