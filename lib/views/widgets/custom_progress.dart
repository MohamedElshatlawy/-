/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/material.dart';
import 'package:ruined_cars/views/colors/mycolors.dart';

showCustomDialog({BuildContext context, String msg}) {
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(CustomColor.green2),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(msg)
              ],
            ),
          ));
}

dismissCustomDialog({BuildContext context}) {
  Navigator.pop(context);
}
