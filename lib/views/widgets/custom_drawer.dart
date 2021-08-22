/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ruined_cars/api/auth.dart';
import 'package:ruined_cars/others/Locale/appLocalization.dart';
import 'package:ruined_cars/others/Locale/localizationProvider.dart';
import 'package:ruined_cars/views/colors/mycolors.dart';
import 'package:ruined_cars/views/emp/profile.dart';
import 'package:ruined_cars/views/settings/settings.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);

    return Container(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          Container(
            child: Image.asset(
              'assets/logo.png',
              scale: 6,
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Profile()));
            },
            title: Text(
              local.translate('profile'),
              style: TextStyle(color: Colors.grey),
            ),
            leading: Icon(
              Icons.person,
              color: CustomColor.green2,
            ),
          ),
          ListTile(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => Settings())),
            title: Text(
              local.translate('setting'),
              style: TextStyle(color: Colors.grey),
            ),
            leading: Icon(
              Icons.settings,
              color: CustomColor.green2,
            ),
          ),
          ListTile(
            onTap: () {
              logoutUserSharedPrefrence();
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            title: Text(
              local.translate('logout'),
              style: TextStyle(color: Colors.grey),
            ),
            leading: Icon(
              Icons.exit_to_app,
              color: CustomColor.green2,
            ),
          )
        ],
      ),
    );
  }
}
