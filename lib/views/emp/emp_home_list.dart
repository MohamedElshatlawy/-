/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ruined_cars/api/request.dart';
import 'package:ruined_cars/api/response.dart';
import 'package:ruined_cars/models/request_model.dart';
import 'package:ruined_cars/others/Locale/appLocalization.dart';
import 'package:ruined_cars/others/Locale/localizationProvider.dart';
import 'package:ruined_cars/provider/request_provider.dart';
import 'package:ruined_cars/provider/user_provider.dart';
import 'package:ruined_cars/views/emp/emp_home_details.dart';

class EmpHomeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var localizationProvider = Provider.of<LocalProvider>(context);
    var local = AppLocalizations.of(context);
    var reqProv = Provider.of<RequestProvider>(context);
    return FutureBuilder<ResponseApi<List<RequestModel>>>(
        future: getUserRequests(user_id: userProvider.user.id),
        builder: (ctx, snap) {
          switch (snap.connectionState) {
            case ConnectionState.none:
              // TODO: Handle this case.
              return Center(
                child: Text(localizationProvider.appLocal.languageCode == "ar"
                    ? 'لا يوجد اتصال بالإنترنت'
                    : 'No internet connection'),
              );
              break;
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active:

            case ConnectionState.done:
              // TODO: Handle this case.
              if (snap.data != null && snap.data.model.isNotEmpty) {
                reqProv.setModel(snap.data.model[0]);
              }
              return (snap.data == null)
                  ? Container()
                  : (snap.data.model.isEmpty)
                      ? Center(
                          child: Text(
                              localizationProvider.appLocal.languageCode == "ar"
                                  ? 'لايوجد طلبات'
                                  : 'No orders found'),
                        )
                      : ListView.builder(
                          itemBuilder: (ctx, index) => Card(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => PoliceHomeDetails(
                                                  model: snap.data.model[index],
                                                )));
                                  },

                                  subtitle: Text(
                                      '${snap.data.model[index].status_name}'),
                                  title: Text(
                                      " ${local.translate('order_num')}  \$  ${snap.data.model[index].id}"),
                                  // subtitle: Text(data.keys.toList()[index]),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_ios,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          itemCount: snap.data.model.length);
              break;
            default:
              return Container();
          }
        });
  }
}
