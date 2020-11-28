import 'dart:async';
import 'dart:io';
import '../model/TodoItem.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _instance = DatabaseHelper._internal();
  static Database _db;

  final String tableItem = "items";
  final String columnId = "id";
  final String columnItemName= "itemname";
  final String columnDateCreated = "datecreated";

  factory DatabaseHelper() {
    if (_instance == null) {
      _instance = DatabaseHelper._internal();
    }
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  initDb() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = documentDirectory.path + "todo_db.db";

    var db = await openDatabase(path, version:  1, onCreate: _onCreate);
    return db;
  }

  FutureOr<void> _onCreate(Database db, int version) async{
    await db.execute(
      "CREATE TABLE $tableItem ($columnId INTEGER PRIMARY KEY, $columnItemName TEXT, $columnDateCreated TEXT)"
    );
  }


  Future<int> saveItem(TodoItem item) async{
      var dbClient = await db;
      int res = await dbClient.insert('$tableItem', item.toMap());
      return res;
  }

  Future<TodoItem> getItem(int id) async {
      var dbClient = await db;
      var result = await dbClient.rawQuery('SELECT * FROM $tableItem WHERE $columnId = $id');
      return TodoItem.fromMap(result.first);
  }

  Future<List> getAllItems() async {
      var dbClient = await db;
      var result = await dbClient.rawQuery('SELECT * FROM $tableItem ORDER BY $columnId DESC');
      return result.toList();
  }

  Future<int> getItemsCount() async {
      var dbClient = await db;
      return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableItem')
      );
  }

  Future<int> deleteItem(int id) async{
      var dbClient = await db;
      return await dbClient.delete(tableItem, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> updateItem(TodoItem item) async {
      var dbClient = await db;
      return await dbClient.update(tableItem, item.toMap(), where: '$columnId = ?', whereArgs: [item.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }


}
