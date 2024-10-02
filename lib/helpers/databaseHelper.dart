import 'dart:developer';
import 'package:adv_flutter_app/Models/DatabaseModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper dbHelper = DbHelper._();

  Database? database;

  Future<void> initializeDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "database.db");
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String Query = """
          CREATE TABLE IF NOT EXISTS User (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            password TEXT NOT NULL
            
          )
        """;
        db.execute(Query);
        log("User Database Created successfully...");
      },
    );
  }

  Future<int> insertUser({required UserModel model}) async {
    if (database == null) {
      await initializeDatabase();
    }
    String query = """
      INSERT INTO User (category_name, category_password)
      VALUES (?, ?);
    """;
    List<dynamic> arguments = [model.name, model.password];
    return database!.rawInsert(query, arguments);
  }

  Future<List<UserModel>> fetchUser() async {
    if (database == null) {
      await initializeDatabase();
    }
    String query = """
      SELECT * FROM User;
    """;
    List<Map<String, dynamic>> data = await database!.rawQuery(query);
    List<UserModel> models = data
        .map(
          (e) => UserModel(
            id: e['id'],
            name: e['category_name'],
            password: e['password'],
          ),
        )
        .toList();
    return models;
  }

  Future<int> deleteUser({required int id}) async {
    if (database == null) {
      await initializeDatabase();
    }
    String query = """
    DELETE FROM User WHERE id = ?;
    """;
    List<int> argument = [id];
    return database!.rawDelete(query, argument);
  }

  Future<int> updateUser({required UserModel model}) async {
    if (database == null) {
      await initializeDatabase();
    }
    String query = """
      UPDATE User SET name = ?,
      password = ?
      WHERE id = ?;
    """;
    List<dynamic> args = [model.name, model.password, model.id];
    return database!.rawUpdate(query, args);
  }
}
