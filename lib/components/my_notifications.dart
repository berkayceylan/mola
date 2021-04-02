import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class MyNotifications {
  FlutterLocalNotificationsPlugin notification;

  initNotification(BuildContext context, Function onSelectNotification) async {
    tz.initializeTimeZones();
    // for(int i = 0; i< tz.timeZoneDatabase.locations.keys.length; i++){
    //   print(tz.timeZoneDatabase.locations.keys.elementAt(i));
    // }
    tz.setLocalLocation(tz.getLocation('Europe/Istanbul'));

    var androidInitialize = AndroidInitializationSettings('app_icon');
    var iOSInitialize = IOSInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    notification = new FlutterLocalNotificationsPlugin();
    notification.initialize(initializationsSettings,
        onSelectNotification: onSelectNotification);

    //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)
  }

  void schedule(String title, String message, Duration duration) {
    int month = tz.TZDateTime.now(tz.local).month;
    int year = tz.TZDateTime.now(tz.local).year;
    int day = tz.TZDateTime.now(tz.local).day;
    print(day.toString() + '--' + month.toString() + '--' + year.toString());

    notification.zonedSchedule(
        9999,
        title,
        message,
        tz.TZDateTime.now(tz.local).add(duration),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  void scheduleByDay({int id, String title, String message, int specificDay, int hour,
      int minutes}) {
    var nowTime = tz.TZDateTime.now(tz.local);

    DateTime dateTimeNow = DateTime.now();

    var dateTime = tz.TZDateTime(tz.local, dateTimeNow.year, dateTimeNow.month, specificDay, hour, minutes);

    while(dateTime.isBefore(nowTime)){
      dateTime = dateTime.add(Duration(days: 7));
    }

    print(dateTime.weekday);

    int month = nowTime.month;
    int year = nowTime.year;
    int day = nowTime.day;
    print(day.toString() + '--' + month.toString() + '--' + year.toString());
    for(int i = 0; i < 4; i++){
      notification.zonedSchedule(
          id + i * 10,
          title,
          message,
          dateTime,
          const NotificationDetails(
              android: AndroidNotificationDetails('your channel id',
                  'your channel name', 'your channel description')),
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
          androidAllowWhileIdle: true);
      dateTime = dateTime.add(Duration(days: 7));

    }
    }

}

// notification.zonedSchedule(5, 'deneme', 'deneme', tz.TZDateTime(tz.local,year,month, day + 1, 03,59),
// const NotificationDetails(
// android: AndroidNotificationDetails('your channel id',
// 'your channel name', 'your channel description')),
// uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime, androidAllowWhileIdle: true);
