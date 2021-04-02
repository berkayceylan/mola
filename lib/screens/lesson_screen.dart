import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:yasam_kocu_orj/components/my_functions.dart';
import 'package:yasam_kocu_orj/components/my_scaffold.dart';
import 'package:yasam_kocu_orj/components/my_slidable.dart';
import 'package:yasam_kocu_orj/contants.dart';
import 'package:yasam_kocu_orj/components/bottom.dart';
import 'package:yasam_kocu_orj/database/database_helper_reminder.dart';
import 'input_lesson.dart';
import 'package:yasam_kocu_orj/database/database_helper_lesson.dart';
import 'package:yasam_kocu_orj/database/model/lesson.dart';

class LessonScreen extends StatefulWidget {
  static final id = 'lesson';
  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  List<Lesson> lessons;
  DatabaseHelperLesson dbHelper = DatabaseHelperLesson();
  DatabaseHelperReminder dbHelperReminder = DatabaseHelperReminder();

  Map<String, List<Lesson>> lessonsDayByDay = Map();

  getLessonDayByDay() async {
    dbHelper.initDb();
    dbHelperReminder.initDb();
    Map<String, List<Lesson>> tempMap = Map();
    for (int i = 0; i < kDaysKey.length; i++) {
      tempMap[kDaysKey[i]] = await dbHelper.getLessonByDay(i);
    }

    setState(() {
      lessonsDayByDay = tempMap;
    });

    dbHelper.setNotification(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    for (int i = 0; i < kDaysKey.length; i++) {
      lessonsDayByDay[kDaysKey[i]] = [];
    }
    super.initState();

    getLessonDayByDay();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: Text('Ders Programı'),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                    itemCount: kDaysKey.length,
                    itemBuilder: (context, inx) {
                      return ExpandablePanel(
                        header: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Card(
                            color: kActiveCardColor,
                            child: ListTile(
                              title: Text(kDaysValue[inx]),
                            ),
                          ),
                        ),
                        collapsed: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            '',
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: List.generate(
                                lessonsDayByDay[kDaysKey[inx]].length, (index) {
                              //Get detail of lesson
                              Lesson lesson =
                                  lessonsDayByDay[kDaysKey[inx]][index];
                              String lessonName = lesson.lessonName;
                              String time = lesson.time;
                              int id = lesson.id;
                              return MySlidable(
                                onDeleteTab: () async {
                                  await MyFunctions.showAlertDialog(context,
                                      () {
                                    setState(() {
                                      dbHelper.deleteLessonById(id);
                                      getLessonDayByDay();
                                    });
                                    Navigator.pop(context);
                                  });
                                },
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => InputLesson(
                                          id: id,
                                        ),
                                      ),
                                    );
                                    getLessonDayByDay();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Card(
                                      color: kActiveCardColor,
                                      child: ListTile(
                                        title: Text(lessonName ?? ''),
                                        trailing: Text(
                                          time,
                                          style: TextStyle(color: kYellowColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        // ignore: deprecated_member_use
                        iconColor: Colors.white,
                      );
                    }),
              ),
            ),
            Bottom(
              text: 'Yeni Ders Kaydi',
              onPressed: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InputLesson()));
                getLessonDayByDay();
              },
            ),
          ],
        ),
      )),
    );
  }
}

// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 8.0),
// child: Card(
// color: kActiveCardColor,
// child: ListTile(
// title: Text('Pazartesi'),
// ),
// ),
// )

// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 8.0),
// child: Card(
//
// color: kActiveCardColor,
// child: ListTile(
//
//
// //leading: Icon(FontAwesomeIcons.check, size: 50.0, color: kBlueColor,),
// title: Text('Pazartesi'),
// // subtitle: Text(
// //     '08.30 - Matematik \n9.30 Kimya \n10.30 Fizik \n10.30 Fizik \n10.30 Fizik \n10.30 Fizik \n10.30 Fizik \n10.30 Fizik \n10.30 Fizik'
// // ),
//
//
// // isThreeLine: true,
// ),
// ),
// ),
