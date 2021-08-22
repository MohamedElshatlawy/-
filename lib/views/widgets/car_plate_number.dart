/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:ruined_cars/others/Locale/appLocalization.dart';

class CarPlateNumber extends StatefulWidget {
  Color plate_Color;
  var parentState;
  var arNumController = TextEditingController();

  var arCharsController = TextEditingController();

  var enNumController = TextEditingController();

  var enCharsController = TextEditingController();

  CarPlateNumber(
      {this.plate_Color,
      this.parentState,
      this.arNumController,
      this.arCharsController,
      this.enCharsController,
      this.enNumController});

  @override
  _CarPlateNumberState createState() => _CarPlateNumberState();
}

class _CarPlateNumberState extends State<CarPlateNumber> {
  Map<String, String> chars = {
    "A": "ا",
    "B": 'ب',
    'J': "ح",
    'D': "د",
    'R': 'ر',
    'S': 'س',
    'X': 'ص',
    'T': 'ط',
    'E': 'ع',
    'G': 'ق',
    'K': 'ك',
    'L': 'ل',
    'Z': "م",
    'N': 'ن',
    'H': 'ه',
    'U': "و",
    'V': "ي"
  };
  List<Color> plateColors = [
    Colors.white,
    Colors.blue,
    Colors.grey,
    Colors.black,
    Colors.yellow
  ];
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

  List<String> arNums = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  List<String> enNums = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

  void arNumListener() {
    String valueArNum = widget.arNumController.text;
    widget.enNumController.removeListener(enNumListner);
    if (valueArNum.isNotEmpty) {
      widget.enNumController.clear();
      valueArNum.split("").forEach((element) {
        if (arNums.contains(element)) {
          var newChar2 = numsMap.keys.firstWhere((k) => numsMap[k] == element);
          print("NewChaaar:" + newChar2);
          widget.enNumController.text += newChar2;
        }
      });
      widget.enNumController.addListener(enNumListner);
    }
  }

  void enNumListner() {
    String valueEnNum = widget.enNumController.text;
    widget.arNumController.removeListener(arNumListener);

    if (valueEnNum.isNotEmpty) {
      widget.arNumController.clear();
      valueEnNum.split("").forEach((element) {
        if (enNums.contains(element)) {
          var newChar2 = numsMap[element];
          print("NewChaaar:" + newChar2);
          widget.arNumController.text += newChar2;
        }
      });
      widget.arNumController.addListener(arNumListener);
    }
  }

  void arCharListener() {
    String valueArChar = widget.arCharsController.text;
    widget.enCharsController.removeListener(enCharListner);
    if (valueArChar.isNotEmpty) {
      widget.enCharsController.clear();
      valueArChar.split("").forEach((element) {
        if (chars.values.contains(element)) {
          print('true');
          var newChar2 = chars.keys.firstWhere((k) => chars[k] == element);
          print("NewChaaar:" + newChar2);
          widget.enCharsController.text += newChar2;
        }
      });
      widget.enCharsController.addListener(enCharListner);
    }
  }

  void enCharListner() {
    String valueEnChar = widget.enCharsController.text;
    widget.arCharsController.removeListener(arCharListener);

    if (valueEnChar.isNotEmpty) {
      widget.arCharsController.clear();
      valueEnChar.split("").forEach((element) {
        if (chars.keys.contains(element)) {
          var newChar2 = chars[element];
          print("NewChaaar:" + newChar2);
          widget.arCharsController.text += newChar2;
        }
      });
      widget.arCharsController.addListener(arCharListener);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.arNumController.addListener(arNumListener);

    widget.enNumController.addListener(enNumListner);

    widget.arCharsController.addListener(arCharListener);

    widget.enCharsController.addListener(enCharListner);
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);

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
                            controller: widget.arNumController,
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
                            maxLength: 4,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(8, 8, 0, 8),
                          child: PinCodeTextField(
                            controller: widget.arCharsController,
                            highlightAnimationBeginColor: Colors.black,
                            highlightAnimationEndColor: Colors.white12,
                            defaultBorderColor: Colors.grey,
                            keyboardType: TextInputType.text,
                            hasUnderline: true,
                            pinBoxWidth:
                                MediaQuery.of(context).size.width * .09,
                            pinBoxRadius: 8,
                            pinBoxHeight:
                                MediaQuery.of(context).size.height * .05,
                            maxLength: 3,
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(8, 8, 0, 8),
                          child: PinCodeTextField(
                            controller: widget.enNumController,
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
                            maxLength: 4,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(8, 8, 0, 8),
                          child: PinCodeTextField(
                            controller: widget.enCharsController,
                            highlightAnimationBeginColor: Colors.black,
                            highlightAnimationEndColor: Colors.white12,
                            defaultBorderColor: Colors.grey,
                            keyboardType: TextInputType.text,
                            hasUnderline: true,
                            pinBoxWidth:
                                MediaQuery.of(context).size.width * .09,
                            pinBoxRadius: 8,
                            pinBoxHeight:
                                MediaQuery.of(context).size.height * .05,
                            maxLength: 3,
                          ),
                        ),
                      ]),
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(local.translate('color_plate')),
                        content: Wrap(runSpacing: 10, spacing: 8, children: [
                          ...plateColors.map((e) => InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  widget.parentState.selectedPlateColor = e;

                                  widget.parentState.setState(() {});
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                      color: e),
                                ),
                              ))
                        ]),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: widget.plate_Color,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
