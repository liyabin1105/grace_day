import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:grace_day/model/GraceDay.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableName = 'graceDayTable';

  final String pointID = 'id';
  final String content = 'content';
  final String remark = 'remark';
  final String time = 'time';
  final String bgType = 'bgType';
  final String color = 'color';
  final String imgUrl = 'imgUrl';

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
//      if (!_db.isOpen) {
//        String databasesPath = await getDatabasesPath();
//        _db = await openDatabase(databasesPath);
//      }
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'gracecard.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableName($pointID INTEGER PRIMARY KEY, $content TEXT, $remark TEXT, $time TEXT, $bgType INTEGER, $color INTEGER, $imgUrl TEXT)');
  }

  //插入一条日程记录
  Future<int> saveCard(GraceDay card) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableName, card.toMap());

    return result;
  }

  //查询所有记录
  Future<List> getAllCards({int limit, int offset}) async {
    var dbClient = await db;
    List<GraceDay> list = [];
    var result = await dbClient.query(
      tableName,
      columns: [pointID, content, remark, time, bgType, color, imgUrl],
    );
    if (result != null && result.length > 0) {
//      result.forEach((item) => list.add(GraceDay.fromMap(item)));
      for (var item in result) {
        GraceDay obj = GraceDay.fromMap(item);
        if(overdueDay(obj)) {
          list.add(obj);
        }
      }
    }
    return list;
  }

  //过滤已经过期的记录
  bool overdueDay(GraceDay item) {
    var _dateTime = DateTime.parse(item.time);
    var _nowTime = DateTime.now().toString().substring(0, 'yyyy-MM-dd'.length);
    int t1 = _dateTime.millisecondsSinceEpoch;
    int t2 = DateTime.parse(_nowTime).millisecondsSinceEpoch;
    if (t1 < t2) {
      return false;
    } else {
      return true;
    }
  }

  //查询已存的总数
  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

  //根据id查询指定记录
  Future<GraceDay> getCard(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableName,
        columns: [
          pointID,
          content,
          remark,
          time,
          bgType,
          color,
          imgUrl
        ],
        where: '$pointID = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return new GraceDay.fromMap(result.first);
    }

    return null;
  }

  //根据id删除指定记录
  Future<int> deleteCard(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableName, where: '$pointID = ?', whereArgs: [id]);
  }

  //根据id修改指定记录
  Future<int> updateCard(GraceDay card) async {
    var dbClient = await db;
    return await dbClient.update(tableName, card.toMap(),
        where: "$pointID = ?", whereArgs: [card.id]);
  }

  //关闭数据库
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}