/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'dart:math';

//Calculate Distance in KM
double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  double theta = lon1 - lon2;
  double dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) +
      cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta));
  dist = acos(dist);
  dist = rad2deg(dist);
  dist = dist * 60 * 1.1515;

  dist = dist * 1.609344;

  return (dist);
}

//Convert degree to radians
double deg2rad(double deg) {
  return (deg * pi / 180.0);
}

//Convert radians to degree
double rad2deg(double rad) {
  return (rad * 180.0 / pi);
}
