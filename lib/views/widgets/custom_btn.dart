/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String text;
  Color background;
  Color foreground;
  Function pressed;
  CustomButton({this.background, this.foreground, this.pressed, this.text});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: pressed,
      child: Text(text),
      color: background,
      textColor: foreground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
