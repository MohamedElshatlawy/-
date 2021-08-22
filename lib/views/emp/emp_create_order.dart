/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'package:ruined_cars/api/connectivity.dart';
import 'package:ruined_cars/api/distanceCalculator.dart';
import 'package:ruined_cars/api/request.dart';
import 'package:ruined_cars/database/requestDb.dart';
import 'package:ruined_cars/models/car_manufacture.dart';
import 'package:ruined_cars/models/car_model.dart';
import 'package:ruined_cars/models/new_area_model.dart';
import 'package:ruined_cars/models/new_baladya.dart';
import 'package:ruined_cars/models/new_city_model.dart';
import 'package:ruined_cars/models/new_state_model.dart';
import 'package:ruined_cars/models/request_model.dart';
import 'package:ruined_cars/others/Locale/appLocalization.dart';
import 'package:ruined_cars/provider/area_provider.dart';
import 'package:ruined_cars/provider/baladya_provider.dart';
import 'package:ruined_cars/provider/car_provider.dart';
import 'package:ruined_cars/provider/city_provider.dart';
import 'package:ruined_cars/provider/request_provider.dart';
import 'package:ruined_cars/provider/state_provider.dart';
import 'package:ruined_cars/provider/user_provider.dart';
import 'package:ruined_cars/views/colors/mycolors.dart';
import 'package:ruined_cars/views/emp/car_map.dart';
import 'package:ruined_cars/views/widgets/car_plate_number.dart';
import 'package:ruined_cars/views/widgets/custom_btn.dart';
import 'package:ruined_cars/views/widgets/custom_progress.dart';
import 'package:ruined_cars/views/widgets/custom_textfield.dart';
import 'package:ruined_cars/views/widgets/old_car_plate_number.dart';

class EmpCreateOrder extends StatefulWidget {
  @override
  _EmpCreateOrderState createState() => _EmpCreateOrderState();
}

class _EmpCreateOrderState extends State<EmpCreateOrder> {
  var arNumController = TextEditingController();
  var enNumController = TextEditingController();
  var arCharController = TextEditingController();
  var enCharController = TextEditingController();
  var chassisController = TextEditingController();
  var oldArNumPlateController = TextEditingController();
  var oldEnNumPlateController = TextEditingController();

  String selectedCarManu;

  String selectedCarModel;
  List<File> images = List(6);
  var request_key = GlobalKey<ScaffoldState>();
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor;
  Color selectedPlateColor = Colors.white;

  NewAreaModel areaModel;
  NewCityModel cityModel;
  BaladyaModel baladyaModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var requestProvider = Provider.of<RequestProvider>(context, listen: false);
    var cityProvider = Provider.of<CityProvider>(context, listen: false);
    var areasProvider = Provider.of<AreaProvider>(context, listen: false);
    var baladyaProvider = Provider.of<BaladyaProvider>(context, listen: false);

    log("CitiesLen:${cityProvider.cities.length}");
    areasProvider.setAreaModel(areasProvider.areas[0]);

    cityProvider.setCityModel(cityProvider.cities[0]);

    Location().getLocation().then((value) {
      // LatLng value = LatLng(24.4526691, 39.6178675);
      double min = calculateDistance(value.latitude, value.longitude,
          areasProvider.areas[0].point.x, areasProvider.areas[0].point.y);
      areaModel = areasProvider.areas[0];

      // double minBaladya = calculateDistance(
      //     value.latitude,
      //     value.longitude,
      //     double.parse(baladyaProvider.baladya[0].lat),
      //     double.parse(baladyaProvider.baladya[0].lng));
      // baladyaModel = baladyaProvider.baladya[0];

      areasProvider.areas.forEach((element) {
        var v = calculateDistance(
            value.latitude, value.longitude, element.point.x, element.point.y);

        if (v < min) {
          min = v;
          areaModel = element;
          setState(() {});
        } else {}
      });

      // baladyaProvider.baladya.forEach((element) {
      //   var v = calculateDistance(value.latitude, value.longitude,
      //       double.parse(element.lat), double.parse(element.lng));

      //   if (v < minBaladya) {
      //     minBaladya = v;
      //     baladyaModel = element;
      //     setState(() {});
      //     log("SmallerThan");
      //   } else {
      //     log("GreaterThan");
      //   }
      // });

      log("SelectedArea:${areaModel.city_id}");
      cityModel = cityProvider.cities.firstWhere(
          (element) => element.id == areaModel.city_id,
          orElse: () => null);
      // cityModel = cityProvider.cities
      //     .firstWhere((element) => element.id == areaModel.city_id);
//log("SelectedCity:${cit.name}");

      cityProvider.setCityModel(cityModel);
      areasProvider.setAreaModel(areaModel);
      baladyaModel = baladyaProvider.baladya.firstWhere(
          (element) => areaModel.baladya_id.toString() == element.id);
      baladyaProvider.setBaladyaModel(baladyaModel);

      requestProvider
          .setCurrentLocation(LatLng(value.latitude, value.longitude));
      setState(() {});
    });
  }

  int plateNumRadioGroup = 1;
  List<String> baladyat = [
    'قباء',
    'العقيق',
    'احد',
    'العوالي',
    'البيداء',
    'العاقول',
    'العيون'
  ];
  String baladyaSelected;
  int orderType = 0; //0->Normal 1->Direct

  @override
  Widget build(BuildContext context) {
    var requestProvider = Provider.of<RequestProvider>(context);
    var carModelsProvider = Provider.of<CarModelProvider>(context);
    var citiesProvider = Provider.of<CityProvider>(context);
    var areaProvider = Provider.of<AreaProvider>(context);
    var stateProvider = Provider.of<StateProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var baladyaProvider = Provider.of<BaladyaProvider>(context);

    var local = AppLocalizations.of(context);

    return Scaffold(
      key: request_key,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            onPressed: null
            // () {
            //   Navigator.push(
            //       context, MaterialPageRoute(builder: (ctx) => CarMap()));

            // }

            ),
        backgroundColor: CustomColor.green3,
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
          local.translate('create_order'),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey)),
                child: DropdownButton<NewStateModel>(
                    isExpanded: true,
                    value: null,
                    underline: Container(),
                    icon: Container(),
                    hint: Center(child: Text('المدينة المنورة')),
                    items: null,
                    onChanged: (v) {
                      stateProvider.setStateModel(v);
                      print(v.id);
                      citiesProvider.setCityModel(null);
                      areaProvider.setAreaModel(null);
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey)),
                child: DropdownButton<NewCityModel>(
                    isExpanded: true,
                    value: cityModel,
                    underline: Container(),
                    hint: Text((cityModel == null) ? "" : cityModel.name),
                    items: null,
                    onChanged: (v) {
                      citiesProvider.setCityModel(v);
                      areaProvider.setAreaModel(null);
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              (cityModel == null)
                  ? Container()
                  : Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey)),
                      child: DropdownButton<NewAreaModel>(
                          isExpanded: true,
                          value: areaModel,
                          underline: Container(),
                          hint: Text((areaModel == null) ? "" : areaModel.name),
                          items: null,
                          onChanged: (v) {
                            areaProvider.setAreaModel(v);
                          }),
                    ),
              SizedBox(
                height: 15,
              ),
              (baladyaModel == null)
                  ? Container()
                  : Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey)),
                      child: DropdownButton<BaladyaModel>(
                          isExpanded: true,
                          value: baladyaModel,
                          underline: Container(),
                          hint: Text(
                              (baladyaModel == null) ? "" : baladyaModel.name),
                          items: null,
                          onChanged: (v) {
                            baladyaProvider.setBaladyaModel(v);
                          }),
                    ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 8),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(8),
              //       border: Border.all(color: Colors.grey)),
              //   child: DropdownButton(
              //       value: baladyaSelected,
              //       hint: Text('اختر البلدية'),
              //       underline: Container(),
              //       isExpanded: true,
              //       items: baladyat
              //           .map((e) => DropdownMenuItem(
              //                 child: Text(e),
              //                 value: e,
              //               ))
              //           .toList(),
              //       onChanged: (v) {
              //         setState(() {
              //           baladyaSelected = v;
              //         });
              //       }),
              // ),

              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey)),
                child: DropdownButton<CarManufacture>(
                    isExpanded: true,
                    value: carModelsProvider.selectedCarManufacture,
                    underline: Container(),
                    hint: Text(local.translate('choose_car')),
                    items: carModelsProvider.carsManufactures
                        .map((e) => DropdownMenuItem<CarManufacture>(
                            child: Text(
                              e.arName,
                            ),
                            value: e))
                        .toList(),
                    onChanged: (v) {
                      carModelsProvider.setCarManufacture(v);
                      carModelsProvider.setCarModel(null);
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              (carModelsProvider.selectedCarManufacture == null)
                  ? Container()
                  : Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey)),
                      child: DropdownButton<CarModel>(
                          underline: Container(),
                          isExpanded: true,
                          value: carModelsProvider.selectedCarModel,
                          hint: Text(local.translate('choose_model')),
                          items: carModelsProvider.carsModel
                              .where((element) =>
                                  element.manufacture_id ==
                                  carModelsProvider.selectedCarManufacture.id)
                              .map((e) => DropdownMenuItem<CarModel>(
                                  child: Text(
                                    e.arName,
                                  ),
                                  value: e))
                              .toList(),
                          onChanged: (v) {
                            carModelsProvider.setCarModel(v);
                          }),
                    ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text('نوع اللوحة'),
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(
                          child: RadioListTile(
                        value: 1,
                        activeColor: CustomColor.green3,
                        groupValue: plateNumRadioGroup,
                        onChanged: (v) {
                          setState(() {
                            plateNumRadioGroup = v;
                            arCharController.clear();
                            arNumController.clear();
                            enCharController.clear();
                            enNumController.clear();
                          });
                        },
                        title: Text('لوحات قديمة'),
                      )),
                      Expanded(
                          child: RadioListTile(
                        value: 2,
                        activeColor: CustomColor.green3,
                        groupValue: plateNumRadioGroup,
                        onChanged: (v) {
                          setState(() {
                            plateNumRadioGroup = v;
                            oldArNumPlateController.clear();
                            oldEnNumPlateController.clear();
                          });
                        },
                        title: Text('لوحات جديدة'),
                      ))
                    ],
                  ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(local.translate('plate_num')),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              (plateNumRadioGroup == 1)
                  ? OldCarPlateNumber(
                      oldArNumController: oldArNumPlateController,
                      oldEnNumController: oldEnNumPlateController,
                    )
                  : CarPlateNumber(
                      plate_Color: selectedPlateColor,
                      arCharsController: arCharController,
                      arNumController: arNumController,
                      enCharsController: enCharController,
                      parentState: this,
                      enNumController: enNumController,
                    ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .4,
                    child: StatefulBuilder(
                        builder: (ctx, builder) => InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                        contentPadding: EdgeInsets.all(8),
                                        title: Text(local.translate('color')),
                                        actions: [
                                          FlatButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                setState(() {});
                                              },
                                              child: Text(
                                                  local.translate('confirm')))
                                        ],
                                        content: Material(
                                          textStyle: TextStyle(fontFamily: ''),
                                          child: MaterialPicker(
                                            enableLabel: true,
                                            pickerColor: pickerColor,
                                            onColorChanged: (color) {
                                              pickerColor = color;
                                              currentColor = pickerColor;
                                              print(
                                                  "SelectedColor:${currentColor.value.toRadixString(16)}");
                                              builder(() {});
                                            },
                                          ),
                                        )));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.5,
                                        color: currentColor ?? pickerColor),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(local.translate('color')),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                            'assets/color-picker.png',
                                            scale: 15,
                                          )
                                        ],
                                      ),
                                    )
                                    // CustomTextField(
                                    //   hint: 'لون السيارة',
                                    //   controller: colorController,
                                    // ),
                                  ],
                                ),
                              ),
                            )),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    color: currentColor ?? pickerColor,
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
                height: 30,
              ),
              Row(
                children: [Text('نوع الطلب')],
              ),
              Row(
                children: [
                  Expanded(
                      child: RadioListTile(
                          title: Text('عادي'),
                          value: 0,
                          groupValue: orderType,
                          onChanged: (v) {
                            setState(() {
                              orderType = v;
                            });
                          })),
                  Expanded(
                      child: RadioListTile(
                          title: Text('فوري'),
                          value: 1,
                          groupValue: orderType,
                          onChanged: (v) {
                            orderType = v;
                            setState(() {});
                          }))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(local.translate('imgs')),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: List.generate(
                      6,
                      (index) => (images.elementAt(index)) == null
                          ? Container(
                              width: 70,
                              height: 80,
                              child: Center(
                                child: InkWell(
                                  onTap: () async {
                                    ImagePicker()
                                        .getImage(
                                            source: ImageSource.camera,
                                            imageQuality: 25)
                                        .then((value) {
                                      if (value != null) {
                                        images[index] = File(value.path);

                                        setState(() {});
                                      }
                                    });
                                  },
                                  child: CircleAvatar(
                                    child: Icon(Icons.camera_alt_rounded),
                                    backgroundColor: CustomColor.splash,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8)),
                            )
                          : Container(
                              width: 80,
                              height: 80,
                              child: Stack(
                                children: [
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        images[index],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: InkWell(
                                        onTap: () {
                                          images[index] = null;
                                          setState(() {});
                                        },
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.red[800],
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ))),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('رقم الشاسيه'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              PinCodeTextField(
                pinBoxOuterPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                wrapAlignment: WrapAlignment.center,
                controller: chassisController,
                highlightAnimationBeginColor: Colors.black,
                highlightAnimationEndColor: Colors.white12,
                defaultBorderColor: Colors.grey,
                keyboardType: TextInputType.text,
                hasUnderline: true,
                pinBoxRadius: 8,
                pinTextStyle: TextStyle(fontFamily: ''),
                pinBoxWidth: MediaQuery.of(context).size.width * .1,
                pinBoxHeight: MediaQuery.of(context).size.height * .05,
                maxLength: 17,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 46,
                child: CustomButton(
                    pressed: () async {
                      // print('CustomColor:${currentColor.toString()}');
                      String arPlates = (plateNumRadioGroup == 1)
                          ? oldArNumPlateController.text
                          : arNumController.text +
                              "/" +
                              arCharController.text.split("").join(" ");

                      String enPlates = (plateNumRadioGroup == 1)
                          ? oldEnNumPlateController.text
                          : enNumController.text +
                              "/" +
                              enCharController.text.split("").join(" ");

                      if (areaProvider.selectedAreaModel == null) {
                        request_key.currentState.showSnackBar(
                            SnackBar(content: Text('قم بتحديد موقع السيارة')));
                      } else if (baladyaProvider.selectedBaladyaModel == null) {
                        request_key.currentState.showSnackBar(
                            SnackBar(content: Text('قم بتحديد موقع السيارة')));
                      } else if (arPlates.isNotEmpty &&
                          enPlates.isNotEmpty &&
                          (arPlates
                                      .trim()
                                      .replaceAll("/", "")
                                      .replaceAll(" ", "")
                                      .length !=
                                  7 ||
                              enPlates
                                      .trim()
                                      .replaceAll("/", "")
                                      .replaceAll(" ", "")
                                      .length !=
                                  7)) {
                        request_key.currentState.showSnackBar(SnackBar(
                            content: Text(
                                'قم بإدخال بيانات لوحة السيارة بطريقة صحيحة')));
                      }

                      // else if (carModelsProvider.selectedCarModel == null) {
                      //   request_key.currentState.showSnackBar(
                      //       SnackBar(content: Text('قم بتحديد نوع السيارة')));
                      // }
                      // else if (plateNumRadioGroup == 1) {
                      //   if (oldArNumPlateController.text.isEmpty ||
                      //       oldEnNumPlateController.text.isEmpty) {
                      //     request_key.currentState.showSnackBar(SnackBar(
                      //         content:
                      //             Text('قم بإدخال رقم السيارة بطريقة صحيحة ')));
                      //   }
                      // } else if (plateNumRadioGroup == 2) {
                      //   if (arCharController.text.length < 3 ||
                      //       arNumController.text.length < 4 ||
                      //       enCharController.text.length < 3 ||
                      //       enNumController.text.length < 4) {
                      //     request_key.currentState.showSnackBar(SnackBar(
                      //         content:
                      //             Text('قم بإدخال رقم السيارة بطريقة صحيحة ')));
                      //   }
                      // }

                      else if (currentColor == null) {
                        request_key.currentState.showSnackBar(
                            SnackBar(content: Text('قم بتحديد لون السيارة ')));
                      } else if (images.any((element) => element == null)) {
                        request_key.currentState.showSnackBar(
                            SnackBar(content: Text('قم بإرفاق صور السيارة')));
                      } else if (chassisController.text.isNotEmpty &&
                          chassisController.text.length < 17) {
                        request_key.currentState.showSnackBar(SnackBar(
                            content: Text('قم بإدخال رقم شاسيه السيارة')));
                      } else {
                        showCustomDialog(
                            context: context, msg: 'جاري ارسال الطلب');

                        checkInternetConnection().then((value) async {
                          if (value == true) {
                            await createRequest(
                                    baladya: baladyaProvider
                                        .selectedBaladyaModel.name,
                                    area_id: areaProvider.selectedAreaModel.id,
                                    city_id:
                                        citiesProvider.selectedCityModel.id,
                                    chassisValue: chassisController.text,
                                    color: currentColor.value
                                        .toRadixString(16)
                                        .substring(2),
                                    lat: requestProvider.currentLocation == null
                                        ? areaProvider.selectedAreaModel.point.x
                                            .toString()
                                        : requestProvider
                                            .currentLocation.latitude
                                            .toString(),
                                    lng: requestProvider.currentLocation == null
                                        ? areaProvider.selectedAreaModel.point.y
                                            .toString()
                                        : requestProvider.currentLocation.longitude
                                            .toString(),
                                    model_id:
                                        carModelsProvider.selectedCarModel == null
                                            ? 0
                                            : int.parse(carModelsProvider
                                                .selectedCarModel.id),
                                    manuId: (carModelsProvider
                                                .selectedCarManufacture ==
                                            null)
                                        ? 0
                                        : int.parse(
                                            carModelsProvider.selectedCarManufacture.id),
                                    state_id: stateProvider.selectedStateModel.id,
                                    user_id: int.parse(userProvider.user.id),
                                    ar_plateNum: arPlates,
                                    en_platNum: enPlates,
                                    plate_color: selectedPlateColor.value.toRadixString(16).substring(2),
                                    orderType: orderType.toString(),
                                    images: images)
                                .whenComplete(() => dismissCustomDialog(context: context))
                                .then((value) {
                              citiesProvider.setCityModel(null);
                              areaProvider.setAreaModel(null);
                              carModelsProvider.setCarManufacture(null);
                              carModelsProvider.setCarModel(null);
                              requestProvider.setCurrentLocation(null);
                              Navigator.pop(context);
                            });
                          } else {
                            var requestModel = RequestModel(
                              areaId:
                                  areaProvider.selectedAreaModel.id.toString(),
                              cityId: citiesProvider.selectedCityModel.id
                                  .toString(),
                              stateId: stateProvider.selectedStateModel.id
                                  .toString(),
                              userId: userProvider.user.id,
                              plateNumber: arNumController.text +
                                  "/" +
                                  arCharController.text.split("").join(" "),
                              enPlateNumber: enNumController.text +
                                  "/" +
                                  enCharController.text.split("").join(" "),
                              plate_color: selectedPlateColor.value
                                  .toRadixString(16)
                                  .substring(2),
                              chassis: chassisController.text,
                              color: currentColor.value
                                  .toRadixString(16)
                                  .substring(2),
                              lat: requestProvider.currentLocation == null
                                  ? areaProvider.selectedAreaModel.point.x
                                      .toString()
                                  : requestProvider.currentLocation.latitude
                                      .toString(),
                              lng: requestProvider.currentLocation == null
                                  ? areaProvider.selectedAreaModel.point.y
                                      .toString()
                                  : requestProvider.currentLocation.longitude
                                      .toString(),
                              modelId: int.parse(
                                      carModelsProvider.selectedCarModel.id)
                                  .toString(),
                            );

                            await insertRequestDatabase(requestModel, images)
                                .whenComplete(
                                    () => dismissCustomDialog(context: context))
                                .then((value) {
                              Fluttertoast.showToast(
                                  msg: "تم انشاء الطلب بنجاح",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: CustomColor.green2,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              citiesProvider.setCityModel(null);
                              areaProvider.setAreaModel(null);
                              carModelsProvider.setCarManufacture(null);
                              carModelsProvider.setCarModel(null);
                              requestProvider.setCurrentLocation(null);
                              Navigator.pop(context);
                            }).catchError((e) {
                              print("ErrorInsertData:$e");
                            });
                          }
                        });
                      }
                    },
                    background: Colors.green,
                    foreground: Colors.white,
                    text: local.translate('send_order')),
              ),
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
