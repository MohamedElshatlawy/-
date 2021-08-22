/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:ruined_cars/api/connectivity.dart';
import 'package:ruined_cars/api/request.dart';
import 'package:ruined_cars/database/imagesDb.dart';
import 'package:ruined_cars/database/requestDb.dart';
import 'package:ruined_cars/models/request_model.dart';
import 'package:ruined_cars/others/Locale/appLocalization.dart';
import 'package:ruined_cars/provider/request_provider.dart';
import 'package:ruined_cars/views/colors/mycolors.dart';
import 'package:ruined_cars/views/emp/emp_home_list.dart';
import 'package:ruined_cars/views/widgets/custom_drawer.dart';
import 'package:ruined_cars/views/widgets/custom_progress.dart';
import 'package:ruined_cars/views/widgets/custom_search_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class EmpHome extends StatefulWidget {
  @override
  _EmpHomeState createState() => _EmpHomeState();
}

class _EmpHomeState extends State<EmpHome> {
  var homeKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var reqProv = Provider.of<RequestProvider>(context);

    return Scaffold(
        key: homeKey,
        drawer: Drawer(
          child: CustomDrawer(),
        ),
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                homeKey.currentState.openDrawer();
              }),
          backgroundColor: CustomColor.green3,
          elevation: 0,
          // actions: [
          //   IconButton(
          //       icon: Icon(
          //         Icons.exit_to_app,
          //         size: 25,
          //         color: Colors.white,
          //       ),
          //       onPressed: () {}),
          //   SizedBox(
          //     width: 10,
          //   ),
          // ],
          actions: [
            IconButton(
                icon: Icon(Icons.sync),
                onPressed: () async {
                  bool networkStatus = await checkInternetConnection();
                  if (networkStatus) {
                    print("True");
                    showCustomDialog(
                        context: context, msg: 'جاري ارسال الطلبات');

                    await queryRequestDatbase().whenComplete(() {
                      print("WhenComplete");
                    }).then((value) async {
                      print("RequestValue:${value.length}");
                      if (value.isNotEmpty) {
                        await Future.forEach<RequestModel>(value,
                            (model) async {
                          await queryImagesDatbase(model.id).then((imgs) async {
                            print("RequestImagesLen:${imgs.length}");
                            List<File> myImgs = [];
                            imgs.forEach((element) {
                              myImgs.add(File(element));
                            });
                            await createRequest(
                                    area_id: int.parse(model.areaId.toString()),
                                    city_id: int.parse(model.cityId.toString()),
                                    chassisValue: model.chassis,
                                    color: model.color,
                                    lat: model.lat,
                                    lng: model.lng,
                                    model_id: int.parse(model.modelId),
                                    state_id: int.parse(model.stateId),
                                    user_id: int.parse(model.userId),
                                    ar_plateNum: model.plateNumber,
                                    en_platNum: model.enPlateNumber,
                                    plate_color: model.plate_color,
                                    images: myImgs)
                                .then((value) {})
                                .catchError((e) {
                              print("ErrorCreateRequestFromDb:$e");
                            });
                          });
                        });
                      }

                      clearRequestsDatabase();

                      dismissCustomDialog(context: context);
                      setState(() {});
                    }).catchError((e) {
                      dismissCustomDialog(context: context);
                      print("ErrorGetDatabaseQuery:$e");
                    });
                  } else {
                    Fluttertoast.showToast(
                        msg: "لا يوجد اتصال بالإنترنت",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: CustomColor.green2,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                })
          ],
          centerTitle: true,
          title: Text(
            local.translate('home'),
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: SpeedDial(
          /// both default to 16

          marginEnd: 18,
          marginBottom: 20,
          icon: Icons.menu,
          activeIcon: Icons.remove,
          buttonSize: 56.0,
          visible: true,

          /// If true user is forced to close dial manually
          /// by tapping main button and overlay is not rendered.
          closeManually: false,

          /// If true overlay will render no matter what.
          renderOverlay: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: CustomColor.green1,
          foregroundColor: Colors.white,
          elevation: 8.0,
          shape: CircleBorder(),
          // orientation: SpeedDialOrientation.Up,
          // childMarginBottom: 2,
          // childMarginTop: 2,
          children: [
            SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: Colors.red,
              labelWidget: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.all(10),
                child: Text('انشاء طلب'),
              ),
              foregroundColor: Colors.white,
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                Navigator.pushNamed(context, '/emp_create_order').then((value) {
                  setState(() {});
                });
              },
              onLongPress: () => print('FIRST CHILD LONG PRESS'),
            ),
            SpeedDialChild(
              child: Icon(Icons.car_repair),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              labelWidget: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.all(10),
                child: Text('استعلام عن سيارة'),
              ),
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) => CustomSearchDialog(
                          model: reqProv.requestModel,
                        ));
              },
              onLongPress: () => print('SECOND CHILD LONG PRESS'),
            ),
            SpeedDialChild(
              child: Icon(Icons.search),
              backgroundColor: Colors.orange[600],
              foregroundColor: Colors.white,
              labelWidget: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text('استعلام عن طلب'),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) => CustomSearchDialog(
                          isOrderSearch: true,
                          model: reqProv.requestModel,
                        ));
              },
              onLongPress: () => print('THIRD CHILD LONG PRESS'),
            ),
            SpeedDialChild(
              child: Icon(Icons.cloud),
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              labelWidget: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text('المنصة'),
              ),
              onTap: () async {
                const _url = 'https://alsaifit.com';

                await canLaunch(_url)
                    ? await launch(_url)
                    : throw 'Could not launch $_url';
              },
              onLongPress: () => print('THIRD CHILD LONG PRESS'),
            ),
          ],
        ),
        //  FloatingActionButton(
        //     onPressed: () {
        //       Navigator.pushNamed(context, '/emp_create_order').then((value) {
        //         setState(() {});
        //       });
        //     },
        //     child: Icon(
        //       Icons.add,
        //       color: Colors.white,
        //     ),
        //     backgroundColor: Colors.green

        //     ),,

        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: Stack(
            children: [
              Center(
                child: Opacity(
                    opacity: .4,
                    child: Image.asset(
                      'assets/logo.png',
                      scale: 4,
                    )),
              ),
              EmpHomeList()
            ],
          ),
        ));
  }
}
