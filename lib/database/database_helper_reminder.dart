import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:yasam_kocu_orj/components/my_functions.dart';
import 'package:yasam_kocu_orj/components/my_notifications.dart';
import 'package:yasam_kocu_orj/database/model/reminder.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yasam_kocu_orj/screens/reminder_screen.dart';
class DatabaseHelperReminder {
  static final DatabaseHelperReminder _instance =
  new DatabaseHelperReminder.internal();
  factory DatabaseHelperReminder() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelperReminder.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "reminder.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }
  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE reminders(id INTEGER PRIMARY KEY, reminderName TEXT, time TEXT, dayName INTEGER)");
  }

  Future<int> saveReminder(Reminder reminder) async {
    var dbClient = await db;
    int res = await dbClient.insert("reminders", reminder.toMap());
    return res;
  }

  Future<List<Reminder>> getAllReminder() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM reminders ORDER BY dayName ASC, time ASC');
    List<Reminder> reminders = new List();

    for (int i = 0; i < list.length; i++) {
      var reminder = new Reminder(
        reminderName: list[i]['reminderName'],
        time: list[i]['time'],
        dayName: list[i]['dayName'],
      );
      // list[i]["reminderName"],list[i]["time"],list[i]["dayName"]
      reminder.setId(list[i]["id"]);
      reminders.add(reminder);
    }


    return reminders;
  }
  setNotification(BuildContext context) async {
    MyNotifications myNotifications = MyNotifications();

    await myNotifications.initNotification(context, (String payload) async {
      await Navigator.push(context,
          MaterialPageRoute(builder: (context) => ReminderScreen()));
    });

    List<Reminder> reminders = await this.getAllReminder();

    int firstMonday = MyFunctions.getFirstMonday();
    print('first monday = ' + firstMonday.toString());
    for (int i = 0; i < reminders.length; i++) {
      Reminder reminder = reminders[i];
      int hour = int.parse(reminder.time.split(':')[0]);
      int minutes = int.parse(reminder.time.split(':')[1]);

      myNotifications.scheduleByDay(
          id: reminder.id + 100,
          title: 'Rutin Hatırtıcı',
          message: reminder.reminderName,
          hour: hour,
          minutes: minutes < 0 ? 0 : minutes,
          specificDay: reminder.dayName + firstMonday);
    }
  }
  Future<List<Reminder>> getReminderByDay(int dayName) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM reminders where dayName = ? ORDER BY time ASC', [dayName]);
    List<Reminder> reminders = new List();

    for (int i = 0; i < list.length; i++) {
      var reminder = new Reminder(
        reminderName: list[i]['reminderName'],
        time: list[i]['time'],
        // dayName: list[i]['dayName'],
      );
      // list[i]["reminderName"],list[i]["time"],list[i]["dayName"]
      reminder.setId(list[i]["id"]);
      reminders.add(reminder);
    }

    return reminders;
  }

  Future<Reminder> getReminderById(int id) async {
    var dbClient = await db;
    List<Map> result =
    await dbClient.rawQuery('SELECT * FROM reminders where id = ?', [id]);
    Reminder reminder = Reminder(
      reminderName: result[0]['reminderName'],
      time: result[0]['time'],
      dayName: result[0]['dayName'],

    );

    return reminder;
  }

  Future<int> deleteReminderById(int id) async {
    var dbClient = await db;
    int res =
    await dbClient.rawDelete('DELETE FROM reminders WHERE id = ?', [id]);
    return res;
  }

  Future<bool> update(Reminder reminder) async {
    var dbClient = await db;
    print('update' + reminder.id.toString() + '--' + reminder.dayName.toString());
    int res = await dbClient.update("reminders", reminder.toMap(),
        where: "id = ?", whereArgs: <int>[reminder.id]);

    return res > 0 ? true : false;
  }
}
