/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ruined_cars/views/colors/mycolors.dart';
import 'package:ruined_cars/views/emp/emp_home_list.dart';
import 'package:ruined_cars/views/police/police_home_map.dart';

class PoliceHome extends StatefulWidget {
  @override
  _PoliceHomeState createState() => _PoliceHomeState();
}

class _PoliceHomeState extends State<PoliceHome> {
  var selections = [true, false];

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
                Icons.exit_to_app,
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
          'طلبات التأشير',
          style: TextStyle(color: CustomColor.primary),
        ),
      ),
      body: Column(
        children: [
          ToggleButtons(
            children: [
              Container(width: 100, child: Center(child: Text('قائمة'))),
              Container(width: 100, child: Center(child: Text('خريطة')))
            ],
            isSelected: selections,
            onPressed: (i) {
              switch (i) {
                case 0:
                  selections[1] = false;
                  selections[0] = true;
                  break;
                default:
                  selections[0] = false;
                  selections[1] = true;
              }
              setState(() {});
            },
            color: Colors.grey,
            selectedColor: CustomColor.primary,
          ),
          Expanded(child: (selections[0]) ? EmpHomeList() : PoliceHomeMap()),
        ],
      ),
    );
  }
}
