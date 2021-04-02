import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yasam_kocu_orj/components/my_functions.dart';
import 'package:yasam_kocu_orj/components/my_notifications.dart';
import 'package:yasam_kocu_orj/database/model/lesson.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yasam_kocu_orj/screens/activity_recommend_screen.dart';
import 'package:yasam_kocu_orj/screens/lesson_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DatabaseHelperLesson {
  static final DatabaseHelperLesson _instance =
      new DatabaseHelperLesson.internal();
  factory DatabaseHelperLesson() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelperLesson.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "lesson.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Lessons(id INTEGER PRIMARY KEY, lessonName TEXT, time TEXT, dayName INTEGER)");
  }

  Future<int> saveLesson(Lesson lesson) async {
    var dbClient = await db;
    int res = await dbClient.insert("Lessons", lesson.toMap());
    return res;
  }

  Future<List<Lesson>> getAllLesson() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Lessons');
    List<Lesson> lessons = new List();

    for (int i = 0; i < list.length; i++) {
      var lesson = new Lesson(
        lessonName: list[i]['lessonName'],
        time: list[i]['time'],
        dayName: list[i]['dayName'],
      );
      // list[i]["lessonName"],list[i]["time"],list[i]["dayName"]
      lesson.setLessonId(list[i]["id"]);
      lessons.add(lesson);
    }

    print(lessons.length);
    return lessons;
  }

  setNotification(BuildContext context) async {



    MyNotifications myNotifications = MyNotifications();

    await myNotifications.initNotification(context, (String payload) async {
      await Navigator.push(context,
          MaterialPageRoute(builder: (context) => LessonScreen()));
    });
    int firstMonday = MyFunctions.getFirstMonday();
    List<Lesson> lessons = await this.getAllLesson();
    for (int i = 0; i < lessons.length; i++) {
      Lesson lesson = lessons[i];
      int hour = int.parse(lesson.time.split(':')[0]);
      int minutes = int.parse(lesson.time.split(':')[1]);
      minutes -= 2;

      myNotifications.scheduleByDay(
          id: lesson.id,
          title: 'Ders Bildirimi',
          message:'2 dk. sonra ' + lesson.lessonName + ' dersiniz başlayacaktır.',
          hour: hour,
          minutes: minutes < 0 ? 0 : minutes,
          specificDay: lesson.dayName + firstMonday);
    }
  }

  Future<List<Lesson>> getLessonByDay(int dayName) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM Lessons where dayName = ? ORDER BY time ASC', [dayName]);
    List<Lesson> lessons = new List();

    for (int i = 0; i < list.length; i++) {
      var lesson = new Lesson(
        lessonName: list[i]['lessonName'],
        time: list[i]['time'],
        // dayName: list[i]['dayName'],
      );
      // list[i]["lessonName"],list[i]["time"],list[i]["dayName"]
      lesson.setLessonId(list[i]["id"]);
      lessons.add(lesson);
    }

    //print(lessons.length);
    return lessons;
  }

  Future<Lesson> getLessonById(int id) async {
    var dbClient = await db;
    List<Map> result =
        await dbClient.rawQuery('SELECT * FROM Lessons where id = ?', [id]);
    Lesson lesson = Lesson(
      lessonName: result[0]['lessonName'],
      time: result[0]['time'],
      dayName: result[0]['dayName'],
    );

    //print(lessons.length);
    return lesson;
  }

  Future<int> deleteLessonById(int id) async {
    var dbClient = await db;
    int res =
        await dbClient.rawDelete('DELETE FROM Lessons WHERE id = ?', [id]);
    return res;
  }

  Future<bool> update(Lesson lesson) async {
    var dbClient = await db;
    print('update' + lesson.id.toString() + '--' + lesson.dayName.toString());
    int res = await dbClient.update("Lessons", lesson.toMap(),
        where: "id = ?", whereArgs: <int>[lesson.id]);

    return res > 0 ? true : false;
  }
}
