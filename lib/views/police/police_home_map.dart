/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ruined_cars/views/colors/mycolors.dart';

class PoliceHomeMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationButtonEnabled: false,
      markers: Set.from([
        Marker(
          markerId: MarkerId('1'),
          position: LatLng(26.6504285, 42.8142701),
        ),
        Marker(
          markerId: MarkerId('2'),
          position: LatLng(24.6799891, 43.4185182),
        ),
        Marker(
          markerId: MarkerId('3'),
          position: LatLng(24.4626751, 43.5613404),
        ),
        Marker(
          markerId: MarkerId('4'),
          position: LatLng(24.9317986, 42.5231324),
        )
      ]),
      mapType: MapType.normal,
      initialCameraPosition:
          CameraPosition(target: LatLng(26.6504285, 42.8142701), zoom: 6.5),
      onMapCreated: (GoogleMapController controller) {},
    );
  }
}
