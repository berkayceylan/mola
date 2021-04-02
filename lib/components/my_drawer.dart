import 'package:flutter/material.dart';
import 'package:yasam_kocu_orj/contants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yasam_kocu_orj/screens/activity_recommend_screen.dart';
import 'package:yasam_kocu_orj/screens/friend_screen.dart';
import 'package:yasam_kocu_orj/screens/home_screen.dart';
import 'package:yasam_kocu_orj/screens/goals_screen.dart';
import 'package:yasam_kocu_orj/screens/information_screen.dart';
import 'package:yasam_kocu_orj/screens/lesson_screen.dart';
import 'package:yasam_kocu_orj/screens/reminder_screen.dart';
import 'package:yasam_kocu_orj/screens/select_app_screen.dart';
import 'package:yasam_kocu_orj/screens/test_screen.dart';
class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kActiveCardColor,
        child: ListView(padding: EdgeInsets.all(0.0), children: <Widget>[


        SizedBox(height: 50.0,),
          ListTile(
            title: Text('Anasayfa'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pushNamed(context, HomeScreen.id);
            },
          ),
          ListTile(
            title: Text('Teknoloji Bağımlılığı'),
            leading: Icon(Icons.chat),
            onTap: () {
              Navigator.pushNamed(context, InformationScreen.id);

            },
          ),
          ListTile(
            title: Text('Hedeflerim'),
            leading: Icon(FontAwesomeIcons.bullseye),
            onTap: (){
              Navigator.pushNamed(context, GoalsScreen.id);

            },
          ),
          ListTile(
            title: Text('Rutin Hatırlatıcı'),
            leading: Icon(FontAwesomeIcons.tachometerAlt),
            onTap: () {
              Navigator.pushNamed(context, ReminderScreen.id);

            },
          ),
          ListTile(
            title: Text('Etkinlik Önerileri'),
            leading: Icon(Icons.chat),
            onTap: () {
              Navigator.pushNamed(context, ActivityRecommendScreen.id);

            },
          ),
          ListTile(
            title: Text('Ders Programı'),
            leading: Icon(FontAwesomeIcons.bookOpen),
            onTap: () {
              Navigator.pushNamed(context, LessonScreen.id);

            },
          ),
          ListTile(
            title: Text('Arkadaşlarım'),
            leading: Icon(FontAwesomeIcons.userFriends),
            onTap: () {
              Navigator.pushNamed(context, FriendScreen.id);

            },
          ),
          ListTile(
            title: Text('Yoksayılan Uygulamalar'),
            leading: Icon(Icons.apps),
            onTap: () {
              Navigator.pushNamed(context, SelectAppScreen.id);
            },
          ),
          Divider(),

          ListTile(
            title: Text('Test Alanı'),
            leading: Icon(Icons.apps),
            onTap: () {
              Navigator.pushNamed(context, TestScreen.id);
            },
          ),

          ListTile(
              title: Text('Kapat'),
              leading: Icon(Icons.close),
              onTap: () {
                Navigator.of(context).pop();
              }),
        ]),
      ),
    );
  }
}
