/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'package:ruined_cars/api/common.dart';
import 'package:ruined_cars/api/request.dart';
import 'package:ruined_cars/models/new_area_model.dart';
import 'package:ruined_cars/models/new_city_model.dart';
import 'package:ruined_cars/models/new_state_model.dart';
import 'package:ruined_cars/models/request_model.dart';
import 'package:ruined_cars/others/Locale/appLocalization.dart';
import 'package:ruined_cars/provider/area_provider.dart';
import 'package:ruined_cars/provider/city_provider.dart';
import 'package:ruined_cars/provider/state_provider.dart';
import 'package:ruined_cars/views/colors/mycolors.dart';
import 'package:ruined_cars/views/emp/emp_notes.dart';
import 'package:ruined_cars/views/emp/view_img.dart';
import 'package:ruined_cars/views/widgets/custom_btn.dart';
import 'package:url_launcher/url_launcher.dart';

class PoliceHomeDetails extends StatefulWidget {
  RequestModel model;
  PoliceHomeDetails({this.model});
  @override
  _PoliceHomeDetailsState createState() => _PoliceHomeDetailsState();
}

class _PoliceHomeDetailsState extends State<PoliceHomeDetails> {
  List<String> imgPaths = [];
  RequestModel args;
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRequestImages(request_id: widget.model.id).whenComplete(() {
      loading = false;
      setState(() {});
    }).then((value) {
      imgPaths.addAll(value.model);
      setState(() {});
    }).catchError((e) {
      print('ErrorGetImagePaths:$e');
    });
  }

  @override
  Widget build(BuildContext context) {
    var cityProvider = Provider.of<CityProvider>(context);
    var staterovider = Provider.of<StateProvider>(context);
    var arearovider = Provider.of<AreaProvider>(context);
    var local = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.green3,
        leading: Container(),
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 25,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          SizedBox(
            width: 10,
          ),
        ],
        centerTitle: true,
        title: Text(
          local.translate('order_details'),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    local.translate('order_num'),
                    style: TextStyle(fontSize: 18),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    color: CustomColor.lightGreen,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    textColor: Colors.white,
                    child: Text(
                      '${widget.model.id} # ',
                      style: TextStyle(fontFamily: ''),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'حالة الطلب',
                    style: TextStyle(fontSize: 18),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    color: CustomColor.lightGreen,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    textColor: Colors.white,
                    child: Text(
                      '${widget.model.status_name}',
                      style: TextStyle(fontFamily: ''),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    local.translate('car_location'),
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: Text(
                      staterovider.states
                              .firstWhere(
                                  (element) =>
                                      element.id.toString() ==
                                      widget.model.stateId,
                                  orElse: () => NewStateModel())
                              .name ??
                          "" +
                              " , " +
                              cityProvider.cities
                                  .firstWhere(
                                      (element) =>
                                          element.id.toString() ==
                                          widget.model.cityId,
                                      orElse: () => NewCityModel())
                                  .name ??
                          "" +
                              " , " +
                              arearovider.areas
                                  .firstWhere(
                                      (element) =>
                                          element.id.toString() ==
                                          widget.model.areaId,
                                      orElse: () => NewAreaModel())
                                  .name ??
                          "",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {},
                child: Container(
                  height: 400,
                  width: double.infinity,
                  color: Colors.white,
                  child: GoogleMap(
                    myLocationButtonEnabled: false,
                    zoomGesturesEnabled: false,
                    markers: Set.from([
                      Marker(
                        markerId: MarkerId('1'),
                        position: LatLng(double.parse(widget.model.lat),
                            double.parse(widget.model.lng)),
                      )
                    ]),
                    mapType: MapType.normal,
                    zoomControlsEnabled: true,
                    mapToolbarEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(double.parse(widget.model.lat),
                            double.parse(widget.model.lng)),
                        zoom: 14),
                    onMapCreated: (GoogleMapController controller) {},
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                    //   color: Colors.,
                    child: Icon(Icons.map),
                    onPressed: () async {
                      String googleUrl =
                          'https://www.google.com/maps/search/?api=1&query=${widget.model.lat},${widget.model.lng}';
                      if (await canLaunch(googleUrl)) {
                        await launch(googleUrl);
                      } else {
                        log("Can't Open App");
                      }
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    local.translate("plate_num"),
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              (!widget.model.plateNumber.contains("/"))
                  ? Directionality(
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
                                        inside:
                                            BorderSide(color: Colors.black)),
                                    children: [
                                      TableRow(children: [
                                        //arabic nums
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(8, 8, 0, 8),
                                          child: PinCodeTextField(
                                            onTextChanged: (v) {},
                                            focusNode: null,
                                            autofocus: false,
                                            controller: TextEditingController(
                                                text: widget.model.plateNumber),
                                            highlightAnimationBeginColor:
                                                Colors.black,
                                            highlightAnimationEndColor:
                                                Colors.white12,
                                            defaultBorderColor: Colors.grey,
                                            keyboardType: TextInputType.text,
                                            hasUnderline: true,
                                            pinBoxRadius: 8,
                                            pinTextStyle:
                                                TextStyle(fontFamily: ''),
                                            pinBoxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .1,
                                            pinBoxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .05,
                                            maxLength: 7,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        //en nums
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(8, 8, 0, 8),
                                          child: PinCodeTextField(
                                            focusNode: null,
                                            autofocus: false,
                                            onTextChanged: (v) {},
                                            controller: TextEditingController(
                                                text:
                                                    widget.model.enPlateNumber),
                                            highlightAnimationBeginColor:
                                                Colors.black,
                                            highlightAnimationEndColor:
                                                Colors.white12,
                                            defaultBorderColor: Colors.grey,
                                            keyboardType: TextInputType.text,
                                            hasUnderline: true,
                                            pinBoxRadius: 8,
                                            pinTextStyle:
                                                TextStyle(fontFamily: ''),
                                            pinBoxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .1,
                                            pinBoxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .05,
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
                    )
                  : Directionality(
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
                                        inside:
                                            BorderSide(color: Colors.black)),
                                    children: [
                                      TableRow(children: [
                                        //arabic nums
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(8, 8, 0, 8),
                                          child: PinCodeTextField(
                                            onTextChanged: (v) {},
                                            focusNode: null,
                                            autofocus: false,
                                            controller: TextEditingController(
                                                text: widget.model.plateNumber
                                                    .split("/")[0]
                                                    .trim()),
                                            highlightAnimationBeginColor:
                                                Colors.black,
                                            highlightAnimationEndColor:
                                                Colors.white12,
                                            defaultBorderColor: Colors.grey,
                                            keyboardType: TextInputType.text,
                                            hasUnderline: true,
                                            pinBoxRadius: 8,
                                            pinTextStyle:
                                                TextStyle(fontFamily: ''),
                                            pinBoxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .1,
                                            pinBoxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .05,
                                            maxLength: 4,
                                          ),
                                        ),
                                        //Arabic chars
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(8, 8, 0, 8),
                                          child: PinCodeTextField(
                                            focusNode: null,
                                            autofocus: false,
                                            controller: TextEditingController(
                                                text: widget.model.plateNumber
                                                    .split("/")[1]
                                                    .split(" ")
                                                    .join()),
                                            highlightAnimationBeginColor:
                                                Colors.black,
                                            highlightAnimationEndColor:
                                                Colors.white12,
                                            defaultBorderColor: Colors.grey,
                                            keyboardType: TextInputType.text,
                                            hasUnderline: true,
                                            pinBoxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .09,
                                            pinBoxRadius: 8,
                                            pinBoxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .05,
                                            maxLength: 3,
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        //arabic nums
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(8, 8, 0, 8),
                                          child: PinCodeTextField(
                                            focusNode: null,
                                            autofocus: false,
                                            onTextChanged: (v) {},
                                            controller: TextEditingController(
                                                text: widget.model.enPlateNumber
                                                    .split("/")[0]
                                                    .trim()),
                                            highlightAnimationBeginColor:
                                                Colors.black,
                                            highlightAnimationEndColor:
                                                Colors.white12,
                                            defaultBorderColor: Colors.grey,
                                            keyboardType: TextInputType.text,
                                            hasUnderline: true,
                                            pinBoxRadius: 8,
                                            pinTextStyle:
                                                TextStyle(fontFamily: ''),
                                            pinBoxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .1,
                                            pinBoxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .05,
                                            maxLength: 4,
                                          ),
                                        ),
                                        //Arabic chars
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(8, 8, 0, 8),
                                          child: PinCodeTextField(
                                            focusNode: null,
                                            autofocus: false,
                                            controller: TextEditingController(
                                                text: widget.model.enPlateNumber
                                                    .split("/")[1]
                                                    .split(" ")
                                                    .join()),
                                            highlightAnimationBeginColor:
                                                Colors.black,
                                            highlightAnimationEndColor:
                                                Colors.white12,
                                            defaultBorderColor: Colors.grey,
                                            keyboardType: TextInputType.text,
                                            hasUnderline: true,
                                            pinBoxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .09,
                                            pinBoxRadius: 8,
                                            pinBoxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .05,
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
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                      color: Color(int.parse("0x" +
                                          "ff" +
                                          widget.model.plate_color)),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    local.translate('color'),
                    style: TextStyle(fontSize: 18),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    color: Color(int.parse("0x" + "ff" + widget.model.color)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    // textColor: Colors.white,
                    // child: Text(
                    //   '${widget.model.color}',
                    //   style: TextStyle(fontFamily: ''),
                    // ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              (widget.model.chassis.isEmpty)
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'رقم الشاسيه',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          widget.model.chassis,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    local.translate('imgs'),
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              (loading == true)
                  ? CircularProgressIndicator()
                  : Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        ...imgPaths.map((e) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => ViewImage(
                                            Common.domain +
                                                "/cars/" +
                                                e.replaceAll("../../", ""))));
                              },
                              child: Container(
                                width: 80,
                                height: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    Common.domain +
                                        "/cars/" +
                                        e.replaceAll("../../", ""),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
              SizedBox(
                height: 15,
              ),

              (widget.model.reason != null)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('سبب الرفض'),
                        Flexible(child: Text(widget.model.reason))
                      ],
                    )
                  : Container(),
              // Container(
              //   height: 45,
              //   width: double.infinity,
              //   child: CustomButton(
              //     background: CustomColor.beighColor,
              //     foreground: Colors.white,
              //     text: local.translate('notes'),
              //     pressed: () {
              //       //     Navigator.pushNamed(context, '/police_approvals');
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (ctx) => OrderNotes(
              //                     orderID: widget.model.id,
              //                   )));
              //     },
              //   ),
              // ),

              SizedBox(
                height: 20,
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         height: 48,
              //         child: CustomButton(
              //           text: 'موافقة',
              //           pressed: () {},
              //           foreground: Colors.white,
              //           background: CustomColor.lightGreen,
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Expanded(
              //       child: Container(
              //         height: 48,
              //         child: CustomButton(
              //           text: 'رفض',
              //           pressed: () {},
              //           foreground: Colors.white,
              //           background: Colors.red[600],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 15,
              // ),

              // Row(
              //   textDirection: TextDirection.rtl,
              //   children: [
              //     Expanded(
              //       child: RaisedButton(
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8)),
              //         textColor: Colors.white,
              //         onPressed: () {},
              //         child: Text('إغلاق الطلب'),
              //         color: CustomColor.green3,
              //       ),
              //     ),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Expanded(
              //       child: RaisedButton(
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8)),
              //         textColor: Colors.white,
              //         onPressed: () {},
              //         child: Text('نقل السيارة'),
              //         color: CustomColor.green3,
              //       ),
              //     )
              //   ],
              // ),

              // Row(
              //   children: [
              //     Expanded(
              //       child: RaisedButton(
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8)),
              //         textColor: Colors.white,
              //         onPressed: () {},
              //         child: Text('فسح السيارة'),
              //         color: CustomColor.green3,
              //       ),
              //     ),
              //   ],
              // ),

              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
