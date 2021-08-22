/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ruined_cars/database/requestDb.dart';
import 'package:ruined_cars/models/request_model.dart';
import 'package:sqflite/sqflite.dart';

Future<int> insertImagesDatabase(List<File> files, requestID) async {
  var db = await openRequestDatabase();
  int rowCounts = 0;
  await Future.forEach(files, (element) async {
    var f = await saveFileLocally(element);
    print("FilePath:${f.path}");
    await db
        .insert("IMAGES", {'file_path': f.path, 'request_id': requestID}).then(
            (value) => rowCounts++);
  });

  db.close();
  return rowCounts;
}

Future<File> saveFileLocally(File file) async {
  final directory = await getApplicationDocumentsDirectory();
  var savedFile = File(directory.path + "/" + file.path.split('/').last);

  await savedFile.writeAsBytes(await file.readAsBytes());
  return savedFile;
}

Future<List<String>> queryImagesDatbase(String requestID) async {
  var db = await openRequestDatabase();
  List<String> paths = [];
  await db.query("IMAGES", where: "request_id=?", whereArgs: [requestID]).then(
      (value) {
    value.forEach((element) {
      paths.add(element['file_path']);
    });
  });

  return paths;
}

clearImagesDatabase() async {
  String sql = "TRUNCATE TABLE IMAGES";
  var db = await openRequestDatabase();
  int rows = await db.delete("IMAGES");
  await db.execute(sql);
}
