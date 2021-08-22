/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ruined_cars/api/response.dart';
import 'package:ruined_cars/models/comment_model.dart';
import 'package:ruined_cars/models/request_model.dart';
import 'package:ruined_cars/others/Locale/appLocalization.dart';
import 'package:ruined_cars/others/Locale/localizationProvider.dart';
import 'package:ruined_cars/views/colors/mycolors.dart';
import 'package:ruined_cars/views/widgets/custom_btn.dart';
import 'package:ruined_cars/views/widgets/custom_textfield.dart';

class OrderNotes extends StatefulWidget {
  String orderID;
  OrderNotes({this.orderID});

  @override
  _OrderNotesState createState() => _OrderNotesState();
}

class _OrderNotesState extends State<OrderNotes> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //   getRequestComments(request_id: widget.orderID);
  }

  @override
  Widget build(BuildContext context) {
    //getRequestComments(request_id: widget.orderID);
    var localizationProvider = Provider.of<LocalProvider>(context);
    var local = AppLocalizations.of(context);
    print("InsideNotes");
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
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
          'الملاحظات',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          margin: EdgeInsets.all(10),
          child: FutureBuilder<ResponseApi<List<CommentModel>>>(
              future: getRequestComments(request_id: widget.orderID),
              initialData: ResponseApi(model: []),
              builder: (ctx, snap) {
                print("Len:${snap.data.model.length}");
                switch (snap.connectionState) {
                  case ConnectionState.none:
                    // TODO: Handle this case.
                    return Center(
                      child: Text(
                          localizationProvider.appLocal.languageCode == "ar"
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

                    return (snap.data.model.isEmpty)
                        ? Center(
                            child: Text(
                                localizationProvider.appLocal.languageCode ==
                                        "ar"
                                    ? 'لايوجد ملاحظات'
                                    : 'No Notes found'),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'رقم الطلب',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    RaisedButton(
                                      onPressed: () {},
                                      color: CustomColor.lightGreen,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      textColor: Colors.white,
                                      child: Text(
                                        widget.orderID,
                                        style: TextStyle(),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'الأمانة',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                Divider(
                                  endIndent:
                                      MediaQuery.of(context).size.width / 2,
                                ),
                                ...snap.data.model
                                    .where((element) =>
                                        element.userType == "amana")
                                    .map(
                                      (e) => Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Text(
                                              (e.description.isEmpty)
                                                  ? "لايوجد ملاحظات"
                                                  : e.description,
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'المرور',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                Divider(
                                  endIndent:
                                      MediaQuery.of(context).size.width / 2,
                                ),
                                ...snap.data.model
                                    .where((element) =>
                                        element.userType == "traffic")
                                    .map(
                                      (e) => Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Text(
                                              (e.description.isEmpty)
                                                  ? "لايوجد ملاحظات"
                                                  : e.description,
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'البحث الجنائي',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                Divider(
                                  endIndent:
                                      MediaQuery.of(context).size.width / 2,
                                ),
                                ...snap.data.model
                                    .where((element) =>
                                        element.userType == "criminal")
                                    .map(
                                      (e) => Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Text(
                                              (e.description.isEmpty)
                                                  ? "لايوجد ملاحظات"
                                                  : e.description,
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'المقاول',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                Divider(
                                  endIndent:
                                      MediaQuery.of(context).size.width / 2,
                                ),
                                ...snap.data.model
                                    .where((element) =>
                                        element.userType == "vendor")
                                    .map(
                                      (e) => Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Text(
                                              (e.description.isEmpty)
                                                  ? "لايوجد ملاحظات"
                                                  : e.description,
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          );

                    break;
                  default:
                    return Container();
                }
              })),
    );
  }
}
