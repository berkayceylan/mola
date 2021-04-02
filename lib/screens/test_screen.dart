import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yasam_kocu_orj/components/my_notifications.dart';
// import 'package:locally/locally.dart';
import 'package:yasam_kocu_orj/components/my_scaffold.dart';
import 'package:yasam_kocu_orj/screens/activity_recommend_screen.dart';
import 'package:yasam_kocu_orj/screens/information_screen.dart';

class TestScreen extends StatefulWidget {
  static final id = 'test';
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  MyNotifications myNotifications = MyNotifications();
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: Text('Test Alanı'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RaisedButton(
              child: Text('30 Dk. kullanım bildirimi'),
              onPressed: () async {
                await myNotifications.initNotification(context,
                    (String payload) async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InformationScreen()));
                });
                myNotifications.schedule(
                    'Gözünü dinlendirmelisin', 'Bugün birazcık gözünü dinlendirsen iyi olur.', Duration(seconds: 5));

              }),
          RaisedButton(
              child: Text('1 saat kullanım bildirimi'),
              onPressed: () async{
                await myNotifications.initNotification(context,
                    (String payload) async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ActivityRecommendScreen()));
                });
                myNotifications.schedule(
                    'Etkinlik tavsiyeleri', '“Hadi biraz gerçek dünyaya ait egzersizler yapalım.', Duration(seconds: 5));
              })
        ],
      ),
    );
  }
}
