/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:ruined_cars/provider/area_provider.dart';
import 'package:ruined_cars/provider/baladya_provider.dart';
import 'package:ruined_cars/provider/car_provider.dart';
import 'package:ruined_cars/provider/city_provider.dart';
import 'package:ruined_cars/provider/request_provider.dart';
import 'package:ruined_cars/provider/state_provider.dart';
import 'package:ruined_cars/provider/user_provider.dart';
import 'package:ruined_cars/views/colors/mycolors.dart';
import 'package:ruined_cars/views/emp/emp_create_order.dart';
import 'package:ruined_cars/views/emp/emp_home.dart';
import 'package:ruined_cars/views/login.dart';
import 'package:ruined_cars/views/emp/emp_notes.dart';
import 'package:ruined_cars/views/police/police_home.dart';
import 'package:ruined_cars/views/emp/emp_home_details.dart';
import 'package:ruined_cars/views/police/police_home_map.dart';
import 'package:ruined_cars/views/register.dart';
import 'package:ruined_cars/views/splash.dart';
import 'package:ruined_cars/views/supervisor/supervisor_add_user.dart';
import 'package:ruined_cars/views/supervisor/supervisor_change_reservation.dart';
import 'package:ruined_cars/views/supervisor/supervisor_delete_car.dart';
import 'package:ruined_cars/views/supervisor/supervisor_delete_user.dart';
import 'package:ruined_cars/views/supervisor/supervisor_home.dart';

import 'others/Locale/appLocalization.dart';
import 'others/Locale/localizationProvider.dart';

main(List<String> args) {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<StateProvider>(
        create: (_) => StateProvider(_),
        lazy: false,
      ),
      ChangeNotifierProvider<CityProvider>(
        create: (_) => CityProvider(_),
        lazy: false,
      ),
      ChangeNotifierProvider<BaladyaProvider>(
        create: (_) => BaladyaProvider(_),
        lazy: false,
      ),
      ChangeNotifierProvider<AreaProvider>(
        create: (_) => AreaProvider(_),
        lazy: false,
      ),
      ChangeNotifierProvider<CarModelProvider>(
        create: (_) => CarModelProvider(_),
        lazy: false,
      ),
      ChangeNotifierProvider<RequestProvider>(
        create: (_) => RequestProvider(),
        lazy: false,
      ),
      ChangeNotifierProvider.value(
        value: UserProvider(),
      ),
      ChangeNotifierProvider<LocalProvider>(
        create: (_) => LocalProvider(),
        lazy: false,
      ),
    ],
    child: MyMaterial(),
  ));
}

class MyMaterial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locProvider = Provider.of<LocalProvider>(context);

    return MaterialApp(
        title: 'السيارات الخربة',
        locale: locProvider.appLocal,
        debugShowCheckedModeBanner: false,
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', ''),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
            primaryColor: CustomColor.green3,
            accentColor: CustomColor.accent,
            fontFamily: 'GE_Dinar'),
        initialRoute: '/',
        routes: {
          '/': (_) => Splash(),
          '/login': (_) => Login(),
          '/register': (_) => Register(),
          '/police_home': (_) => PoliceHome(),
          '/police_home_details': (_) => PoliceHomeDetails(),
          '/police_home_map': (_) => PoliceHomeMap(),
          // '/police_approvals': (_) => PoliceApprovals(),
          '/supervisor_home': (_) => SupervisorHome(),
          '/supervisor_change_reservation': (_) =>
              SupervisorChangeReservation(),
          '/supervisor_delete_car': (_) => SupervisorDeleteCar(),
          '/supervisor_delete_user': (_) => SupervisorDeleteUser(),
          '/supervisor_add_user': (_) => SupervisorAddUser(),
          '/emp_home': (_) => EmpHome(),
          '/emp_create_order': (_) => EmpCreateOrder()
        });
  }
}
