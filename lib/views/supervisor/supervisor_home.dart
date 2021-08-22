/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/material.dart';
import 'package:ruined_cars/views/colors/mycolors.dart';
import 'package:ruined_cars/views/widgets/custom_btn.dart';

class SupervisorHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: CustomColor.primary,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(
                Icons.notifications_active,
                size: 25,
                color: CustomColor.primary,
              ),
              onPressed: () {}),
          SizedBox(
            width: 10,
          ),
        ],
        centerTitle: true,
        title: Text(
          'الرئيسية',
          style: TextStyle(color: CustomColor.primary),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 48,
                width: double.infinity,
                child: CustomButton(
                  background: CustomColor.primary,
                  foreground: Colors.white,
                  text: 'تغيير مدة الحجز',
                  pressed: () {
                    Navigator.pushNamed(
                        context, '/supervisor_change_reservation');
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 48,
                width: double.infinity,
                child: CustomButton(
                  background: CustomColor.primary,
                  foreground: Colors.white,
                  text: 'حذف مركبة',
                  pressed: () {
                    Navigator.pushNamed(context, '/supervisor_delete_car');
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 48,
                width: double.infinity,
                child: CustomButton(
                  background: CustomColor.primary,
                  foreground: Colors.white,
                  text: 'إضافة مستخدم',
                  pressed: () {
                    Navigator.pushNamed(context, '/supervisor_add_user');
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 48,
                width: double.infinity,
                child: CustomButton(
                  background: CustomColor.primary,
                  foreground: Colors.white,
                  text: 'حذف مستخدم',
                  pressed: () {
                    Navigator.pushNamed(context, '/supervisor_delete_user');
                  },
                ),
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
