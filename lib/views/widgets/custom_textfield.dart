/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/material.dart';
import 'package:ruined_cars/views/colors/mycolors.dart';

class CustomTextField extends StatelessWidget {
  String hint;
  bool isNumber;
  bool isPassword;
  bool isTextArea;
  TextEditingController controller;
  CustomTextField(
      {this.hint,
      this.isTextArea = false,
      this.isNumber = false,
      this.isPassword = false,
      this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: CustomColor.green3,
          )),
      child: TextField(
        controller: controller,
        style: TextStyle(fontFamily: ''),
        keyboardType: (isNumber) ? TextInputType.number : TextInputType.text,
        obscureText: isPassword,
        minLines: (isTextArea) ? 3 : 1,
        maxLines: (isTextArea) ? 3 : 1,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(10),
            hintText: hint,
            suffixIcon: (isPassword)
                ? IconButton(
                    icon: Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {})
                : Container(
                    width: 0,
                  ),
            hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
