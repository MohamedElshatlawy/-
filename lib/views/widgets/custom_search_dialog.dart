/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ruined_cars/api/search.dart';
import 'package:ruined_cars/models/request_model.dart';
import 'package:ruined_cars/views/colors/mycolors.dart';
import 'package:ruined_cars/views/emp/emp_home_details.dart';
import 'package:ruined_cars/views/widgets/custom_progress.dart';
import 'package:ruined_cars/views/widgets/custom_textfield.dart';

class CustomSearchDialog extends StatefulWidget {
  RequestModel model;
  bool isOrderSearch;

  CustomSearchDialog({this.isOrderSearch = false, this.model});

  @override
  _CustomSearchDialogState createState() => _CustomSearchDialogState();
}

class _CustomSearchDialogState extends State<CustomSearchDialog> {
  var controller = TextEditingController();

  int chassisRadio = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text((widget.isOrderSearch) ? 'استعلام عن طلب' : 'استعلام عن سيارة'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            controller: controller,
            hint: (widget.isOrderSearch) ? 'رقم الطلب' : 'رقم اللوحة',
          ),
          SizedBox(
            height: 10,
          ),
          (widget.isOrderSearch)
              ? Container()
              : Row(
                  children: [
                    Expanded(
                        child: RadioListTile(
                            value: 1,
                            title: Text('رقم شاسيه'),
                            groupValue: chassisRadio,
                            onChanged: (v) {
                              chassisRadio = v;
                              setState(() {});
                            })),
                    Expanded(
                        child: RadioListTile(
                            value: 0,
                            title: Text('رقم اللوحة'),
                            groupValue: chassisRadio,
                            onChanged: (v) {
                              chassisRadio = v;
                              setState(() {});
                            }))
                  ],
                )
        ],
      ),
      actions: [
        RaisedButton(
          onPressed: () async {
            if (controller.text.isNotEmpty) {
              if (!widget.isOrderSearch) {
                //Search by car plate
                if (chassisRadio == 1 && (controller.text.length < 6)) {
                  Fluttertoast.showToast(msg: 'الحد الادنى للشاسيه ٦ احرف');
                  return;
                }
                if (chassisRadio == 0 &&
                    controller.text
                            .trim()
                            .replaceAll("/", "")
                            .replaceAll(" ", "")
                            .length !=
                        7) {
                  String s = controller.text.trim().replaceAll("/", "");
                  log("MyString:${s.length}");
                  return;
                }
                showCustomDialog(context: context, msg: 'جاري الاستعلام');
                await search(
                        plateNumber: controller.text,
                        isChassis: (chassisRadio == 1) ? true : false)
                    .whenComplete(() => Navigator.pop(context))
                    .then((value) {
                  if (value.success == 1 &&
                      value.model != null &&
                      value.model.length == 1) {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ...value.model.map((e) => ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        PoliceHomeDetails(
                                                          model: e,
                                                        )));
                                          },
                                          title: Text("طلب رقم :${e.id}"),
                                        ))
                                  ],
                                ),
                              ),
                            ));
                  }
                });
              } else {
                showCustomDialog(context: context, msg: 'جاري الاستعلام');
                await search(orderNumber: controller.text)
                    .whenComplete(() => Navigator.pop(context))
                    .then((value) {
                  if (value.success == 1 &&
                      value.model != null &&
                      (value.model.length == 1)) {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ...value.model.map((e) => ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        PoliceHomeDetails(
                                                          model: e,
                                                        )));
                                          },
                                          title: Text("طلب رقم :${e.id}"),
                                        ))
                                  ],
                                ),
                              ),
                            ));
                  }
                });
              }
            }
          },
          color: CustomColor.green3,
          textColor: Colors.white,
          child: Text('استعلام'),
        )
      ],
    );
  }
}
