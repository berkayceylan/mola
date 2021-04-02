import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yasam_kocu_orj/components/my_scaffold.dart';
import 'package:yasam_kocu_orj/components/reusable_card.dart';
import 'package:yasam_kocu_orj/contants.dart';
import 'package:yasam_kocu_orj/components/bottom.dart';
import 'package:yasam_kocu_orj/components/my_functions.dart';
import 'package:yasam_kocu_orj/components/input_components.dart';
import 'package:yasam_kocu_orj/database/database_helper_lesson.dart';
import 'package:yasam_kocu_orj/database/model/lesson.dart';
import 'package:yasam_kocu_orj/screens/lesson_screen.dart';

class InputLesson extends StatefulWidget {
  final int id;
  InputLesson({this.id = -1});
  @override
  _InputLessonState createState() => _InputLessonState();
}

class _InputLessonState extends State<InputLesson> {
  String selectedDay = kDaysValue[0];

  String selectedLessonName = '';

  int selectedHour = 0;
  int selectedMinutes = 0;

  FixedExtentScrollController controllerHour = FixedExtentScrollController();
  FixedExtentScrollController controllerMinutes = FixedExtentScrollController();
  Lesson lesson;
  getReminder() async {
    DatabaseHelperLesson dbHelper = DatabaseHelperLesson();
    await dbHelper.initDb();

    lesson = await dbHelper.getLessonById(widget.id);

    setState(() {
      selectedHour = int.parse(lesson.time.split(':')[0]);
      controllerHour.jumpToItem(selectedHour);

      selectedMinutes = int.parse(lesson.time.split(':')[1]);
      controllerMinutes.jumpToItem(selectedMinutes);

      selectedLessonName = lesson.lessonName;
      selectedDay = kDaysValue[lesson.dayName];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.id != -1) {
      getReminder();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: Text('Ders Girisi Yap'),
      resizeToAvoidBottomPadding: false,
      body: Container(
          child: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      style: myTitleText,
                      controller:
                          TextEditingController(text: selectedLessonName),
                      onChanged: (val) {
                        selectedLessonName = val;
                      },
                      decoration:
                          InputDecoration(hintText: 'Ders adını giriniz.'),
                    ),
                  ),
                  ReusableCard(
                    cardChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Hangi Gün:',
                            style: kTitleText.copyWith(
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton(
                              style: kTitleText.copyWith(
                                  fontWeight: FontWeight.normal),
                              hint: Text('Hangi Günler?'),
                              value: selectedDay,
                              onChanged: (String newValue) {
                                setState(() {
                                  selectedDay = newValue;
                                });

                                print(kDaysValue.indexWhere((element) =>
                                    element.endsWith(selectedDay)));
                              },
                              items: kDaysValue.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Time Selector
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Saat: ',
                            style: myTitleText,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          child: CupertinoPicker.builder(
                            childCount: 60,
                            backgroundColor: kMainBackgroundColor,
                            itemExtent: 30,
                            scrollController: controllerHour,
                            itemBuilder: (context, inx) {
                              return Text(
                                MyFunctions.addZero(inx),
                                style: TextStyle(color: Colors.white),
                              );
                            },
                            onSelectedItemChanged: (val) {
                              selectedHour = val;
                            },
                          ),
                        ),
                      ),
                      Text(
                        ':',
                        style: myTitleText,
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          child: CupertinoPicker.builder(
                            childCount: 60,
                            backgroundColor: kMainBackgroundColor,
                            itemExtent: 30,
                            scrollController: controllerMinutes,
                            itemBuilder: (context, inx) {
                              return Text(
                                MyFunctions.addZero(inx),
                                style: TextStyle(color: Colors.white),
                              );
                            },
                            onSelectedItemChanged: (val) {
                              selectedMinutes = val;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Bottom(
              text: 'Kaydet',
              onPressed: () {
                if (selectedLessonName == '') {
                  return MyFunctions.showMyDialog(context,
                      title: 'Ders adı boş olamaz!', btnText: 'Tamam');
                }

                DatabaseHelperLesson dbHelper = DatabaseHelperLesson();
                dbHelper.initDb();

                Lesson lesson = Lesson(
                    dayName: kDaysValue
                        .indexWhere((element) => element.contains(selectedDay)),
                    time: MyFunctions.addZero(selectedHour) +
                        ':' +
                        MyFunctions.addZero(selectedMinutes),
                    lessonName: selectedLessonName);
                if (widget.id != -1) {
                  lesson.id = widget.id;
                  dbHelper.update(lesson);
                  Navigator.pop(context);

                  return 0;
                }
                dbHelper.saveLesson(lesson);

                Navigator.pop(context);
              },
            ),
          ],
        ),
      )),
    );
  }
}

//class CupertinoNumberGenerator extends StatelessWidget {
//  final int count;
//  final Function onChange;
//  CupertinoNumberGenerator({@required this.count, @required this.onChange});
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      height: 100,
//      child: CupertinoPicker(
//        backgroundColor: kMainBackgroundColor,
//
//        itemExtent: 30,
//        scrollController:
//        FixedExtentScrollController(initialItem: 0),
//        children: List<Widget>.generate(this.count, (int inx) {
//          return Text(
//            MyFunctions.addZero(inx),
//            style: TextStyle(color: Colors.white),
//          );
//        }),
//
//        onSelectedItemChanged: (val){
//
//        },
//      ),
//    );
//  }
//}
