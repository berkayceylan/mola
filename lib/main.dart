import 'package:flutter/material.dart';
import 'package:yasam_kocu_orj/contants.dart';
import 'package:yasam_kocu_orj/screens/activity_recommend_screen.dart';
import 'package:yasam_kocu_orj/screens/friend_screen.dart';
import 'package:yasam_kocu_orj/screens/home_screen.dart';
import 'package:yasam_kocu_orj/screens/goals_screen.dart';
import 'package:yasam_kocu_orj/screens/information_screen.dart';
import 'package:yasam_kocu_orj/screens/lesson_screen.dart';
import 'package:yasam_kocu_orj/screens/reminder_screen.dart';
import 'package:yasam_kocu_orj/screens/select_app_screen.dart';
import 'package:yasam_kocu_orj/screens/test_screen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      theme: ThemeData.dark().copyWith(

      primaryColor: Color(0xff090C22),
      scaffoldBackgroundColor: kMainBackgroundColor,
    ),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id : (context) => HomeScreen(),
        GoalsScreen.id : (context) =>  GoalsScreen(),
        ReminderScreen.id : (context) => ReminderScreen(),
        LessonScreen.id : (context) => LessonScreen(),
        SelectAppScreen.id : (context) => SelectAppScreen(),
        ActivityRecommendScreen.id : (context) => ActivityRecommendScreen(),
        InformationScreen.id : (context) => InformationScreen(),
        FriendScreen.id : (context) => FriendScreen(),
        TestScreen.id : (context) => TestScreen(),
      },
    );
  }
}

