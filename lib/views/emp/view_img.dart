/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:ruined_cars/views/colors/mycolors.dart';

class ViewImage extends StatelessWidget {
  String imgURL;
  ViewImage(this.imgURL);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.green3,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          'عرض الصورة',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(imgURL),
          minScale: .1,
        ),
      ),
    );
  }
}
