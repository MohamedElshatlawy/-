/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
import 'dart:io';

import 'package:path/path.dart';
import 'package:ruined_cars/models/request_model.dart';
import 'package:sqflite/sqflite.dart';

import 'imagesDb.dart';

Future<Database> openRequestDatabase() async {
  // Get a location using getDatabasesPath
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'request.db');

// open the database
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        'CREATE TABLE REQUEST (id INTEGER PRIMARY KEY AUTOINCREMENT, model_id TEXT, plate_number TEXT, color TEXT,lat TEXT ,lng TEXT,state_id TEXT,city_id TEXT,area_id TEXT,user_id TEXT,enPlateNumber TEXT,plate_color TEXT, chassis TEXT)');
    await db.execute(
        'CREATE TABLE IMAGES (id INTEGER PRIMARY KEY AUTOINCREMENT, file_path TEXT, request_id TEXT)');
  });

  return database;
}

Future<int> insertRequestDatabase(RequestModel model, List<File> files) async {
  print("RequestDataOffline---------:${model.toJson()}");

  var db = await openRequestDatabase();
  int row = await db.insert("REQUEST", model.toJson());
  print("DataSuccessInserted:$row");
  int numOfrows = await insertImagesDatabase(files, row.toString());
  print("NumberOfRowsOfFilesInserted---------:$numOfrows");
  db.close();
  return row;
}

Future<List<RequestModel>> queryRequestDatbase() async {
  print("InsideQueryDab");
  var db = await openRequestDatabase();
  List<RequestModel> models = [];
  await db.query("REQUEST").then((value) async {
    await Future.forEach(value, (element) async {
      var model = RequestModel.fromJson(element);
      List<String> imgs = await queryImagesDatbase(model.id);
      model.imgPaths.addAll(imgs);
      models.add(model);
    });
  });
  //db.close();
  return models;
}

clearRequestsDatabase() async {
  String sql1 = "TRUNCATE TABLE REQUEST";
  String sql2 = "TRUNCATE TABLE IMAGES";

  var db = await openRequestDatabase();
  await db.delete("REQUEST");
  await db.delete("IMAGES");

  // await db.execute(sql1);
  // await db.execute(sql2);
}
