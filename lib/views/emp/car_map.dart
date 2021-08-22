/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:ruined_cars/provider/request_provider.dart';
import 'package:ruined_cars/views/colors/mycolors.dart';
import 'package:ruined_cars/views/widgets/custom_btn.dart';

class CarMap extends StatefulWidget {
  @override
  _CarMapState createState() => _CarMapState();
}

class _CarMapState extends State<CarMap> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng currentLocation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Location().getLocation().then((value) {
      currentLocation = LatLng(value.latitude, value.longitude);
      print("CurrrentLocation:${currentLocation.latitude}");
      setState(() {});
      _controller.future.then((value) {
        value.animateCamera(CameraUpdate.newLatLng(currentLocation));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var requestProvider = Provider.of<RequestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.green3,
        title: Text(
          'تحديد موقع السيارة',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Stack(
        children: [
          Center(
            child: GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                onCameraMove: (pos) {
                  requestProvider.setCurrentLocation(pos.target);
                  currentLocation = pos.target;
                  setState(() {});
                },
                markers: Set.from([
                  Marker(
                      markerId: MarkerId('1'),
                      position: currentLocation ?? LatLng(0.0, 0.0))
                ]),
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: currentLocation ?? LatLng(0.0, 0.0), zoom: 9),
                onMapCreated: (GoogleMapController controller) {
                  if (!_controller.isCompleted) {
                    _controller.complete(controller);
                  }
                }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              width: double.infinity,
              height: 46,
              child: CustomButton(
                pressed: () {
                  Navigator.pop(context);
                },
                background: Colors.green,
                foreground: Colors.white,
                text: 'تأكيد',
              ),
            ),
          )
        ],
      ),
    );
  }
}
