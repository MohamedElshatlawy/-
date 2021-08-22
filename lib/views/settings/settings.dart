/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ruined_cars/others/Locale/appLocalization.dart';
import 'package:ruined_cars/others/Locale/localizationProvider.dart';
import 'package:ruined_cars/views/colors/mycolors.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    var local = Provider.of<LocalProvider>(context);
    var localProv = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localProv.translate('setting')),
      ),
      body: ListTile(
        leading: Icon(Icons.language),
        title: Text(localProv.translate('change_lang')),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text((local.appLocal.languageCode == "ar") ? 'English' : 'العربية'),
            SizedBox(
              width: 10,
            ),
            CupertinoSwitch(
                value: local.appLocal.languageCode == "ar" ? true : false,
                activeColor: CustomColor.green3,
                trackColor: CustomColor.green2,
                onChanged: (v) {
                  local.changeLanguage(local.appLocal.languageCode == "ar"
                      ? Locale('en')
                      : Locale('ar'));
                }),
          ],
        ),
      ),
    );
  }
}
