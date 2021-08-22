/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class OldCarPlateNumber extends StatefulWidget {
  var oldArNumController = TextEditingController();
  var oldEnNumController = TextEditingController();

  OldCarPlateNumber({this.oldArNumController, this.oldEnNumController});

  @override
  _OldCarPlateNumberState createState() => _OldCarPlateNumberState();
}

class _OldCarPlateNumberState extends State<OldCarPlateNumber> {
  List<String> arNums = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  List<String> enNums = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  Map<String, String> numsMap = {
    '0': '٠',
    '1': '١',
    '2': '٢',
    '3': '٣',
    '4': '٤',
    '5': '٥',
    '6': '٦',
    '7': '٧',
    '8': '٨',
    '9': '٩'
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.oldArNumController.addListener(arNumListener);

    widget.oldEnNumController.addListener(enNumListner);
  }

  void arNumListener() {
    String valueArNum = widget.oldArNumController.text;
    widget.oldEnNumController.removeListener(enNumListner);
    if (valueArNum.isNotEmpty) {
      widget.oldEnNumController.clear();
      valueArNum.split("").forEach((element) {
        if (arNums.contains(element)) {
          var newChar2 = numsMap.keys.firstWhere((k) => numsMap[k] == element);
          print("NewChaaar:" + newChar2);
          widget.oldEnNumController.text += newChar2;
        }
      });
      widget.oldEnNumController.addListener(enNumListner);
    }
  }

  void enNumListner() {
    String valueEnNum = widget.oldEnNumController.text;
    widget.oldArNumController.removeListener(arNumListener);

    if (valueEnNum.isNotEmpty) {
      widget.oldArNumController.clear();
      valueEnNum.split("").forEach((element) {
        if (enNums.contains(element)) {
          var newChar2 = numsMap[element];
          print("NewChaaar:" + newChar2);
          widget.oldArNumController.text += newChar2;
        }
      });
      widget.oldArNumController.addListener(arNumListener);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: MediaQuery.of(context).size.height * .14,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Expanded(
                flex: 15,
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                  ),
                  child: Table(
                    columnWidths: {1: FractionColumnWidth(.4)},
                    border: TableBorder.symmetric(
                        inside: BorderSide(color: Colors.black)),
                    children: [
                      TableRow(children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(8, 8, 0, 8),
                          child: PinCodeTextField(
                            onTextChanged: (v) {},
                            controller: widget.oldArNumController,
                            highlightAnimationBeginColor: Colors.black,
                            highlightAnimationEndColor: Colors.white12,
                            defaultBorderColor: Colors.grey,
                            keyboardType: TextInputType.text,
                            hasUnderline: true,
                            pinBoxRadius: 8,
                            pinTextStyle: TextStyle(fontFamily: ''),
                            pinBoxWidth: MediaQuery.of(context).size.width * .1,
                            pinBoxHeight:
                                MediaQuery.of(context).size.height * .05,
                            maxLength: 7,
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(8, 8, 0, 8),
                          child: PinCodeTextField(
                            controller: widget.oldEnNumController,
                            highlightAnimationBeginColor: Colors.black,
                            highlightAnimationEndColor: Colors.white12,
                            defaultBorderColor: Colors.grey,
                            keyboardType: TextInputType.number,
                            pinTextStyle: TextStyle(fontFamily: ''),
                            hasUnderline: true,
                            onTextChanged: (v) {
                              //check if last char in ar list add it to en,
                            },
                            pinBoxRadius: 8,
                            pinBoxWidth: MediaQuery.of(context).size.width * .1,
                            pinBoxHeight:
                                MediaQuery.of(context).size.height * .05,
                            maxLength: 7,
                          ),
                        ),
                      ]),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
