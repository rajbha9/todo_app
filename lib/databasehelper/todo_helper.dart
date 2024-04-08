import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/todomodel.dart';

class DBTodo {
  DBTodo._();

  static DBTodo dbTodo = DBTodo._();
  Database? database;

  Future<Database?> initDB() async {
    String path = await getDatabasesPath();
    String dbpath = join(path, 'todo.db');
    database = await openDatabase(dbpath, version: 1,
        onCreate: (Database db, _) async {
      String sql =
          'CREATE TABLE IF NOT EXISTS todo(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, date TEXT, time TEXT);';
      await db.execute(sql);
    });
    return database;
  }

  Future<void> insertTodoData(
      String name, String description, String date, String time) async {
    database = await initDB();

    String sql =
        'INSERT INTO todo (name,description,date,time) VALUES(?,?,?,?)';

    List args = [name, description, date, time];

    await database!.rawInsert(sql, args);
  }

  Future<List<Map<String, dynamic>>> fetchSingleTodoData(int id) async {
    database = await initDB();

    String sql = 'SELECT * FROM Todo WHERE id=?';

    List args = [id];

    List<Map<String, dynamic>> fetchSingleData =
        await database!.rawQuery(sql, args);

    return fetchSingleData;
  }

  Future<List<Todo>> fetchTodoData() async {
    database = await initDB();

    String sql = 'SELECT * FROM todo';

    List<Map<String, dynamic>> data = await database!.rawQuery(sql);

    List<Todo> fetchData = data
        .map(
          (e) => Todo(
            id: e['id'],
            name: e['name'],
            description: e['description'],
            date: e['date'],
            time: e['time'],
          ),
        )
        .toList();

    return fetchData;
  }

  Future<void> deleteTodoData(int id) async {
    database = await initDB();

    String sql = 'DELETE FROM todo WHERE id=?';

    List args = [id];

    await database!.rawDelete(sql, args);
  }

  Future<void> updateTodoData(
      String name, String description, String date, String time, int id) async {
    database = await initDB();

    String sql =
        "UPDATE todo SET name=?,description=?,date=?,time=?, WHERE id=?";

    List args = [name, description, date, time,id];

    await database!.rawUpdate(sql, args);
  }
}
