import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yasam_kocu_orj/components/input_components.dart';
import 'package:yasam_kocu_orj/components/my_functions.dart';
import 'package:yasam_kocu_orj/components/my_scaffold.dart';
import 'package:yasam_kocu_orj/components/reusable_card.dart';
import 'package:yasam_kocu_orj/contants.dart';
import 'package:yasam_kocu_orj/components/my_drawer.dart';
import 'package:yasam_kocu_orj/components/bottom.dart';
import 'package:yasam_kocu_orj/database/database_helper_reminder.dart';
import 'package:yasam_kocu_orj/database/model/reminder.dart';

class InputReminder extends StatefulWidget {
  final int id;
  InputReminder({this.id = -1});

  @override
  _InputReminderState createState() => _InputReminderState();
}

class _InputReminderState extends State<InputReminder> {
  String selectedDay = kDaysValue[0];
  TextStyle myTitleText = kTitleText.copyWith(fontWeight: FontWeight.normal);

  String selectedReminderName = '';

  int selectedHour = 0;
  int selectedMinutes = 0;

  FixedExtentScrollController controllerHour = FixedExtentScrollController();
  FixedExtentScrollController controllerMinutes = FixedExtentScrollController();
  Reminder reminder;
  getLesson() async {
    DatabaseHelperReminder dbHelper = DatabaseHelperReminder();
    await dbHelper.initDb();

    reminder = await dbHelper.getReminderById(widget.id);

    setState(() {
      selectedHour = int.parse(reminder.time.split(':')[0]);
      controllerHour.jumpToItem(selectedHour);

      selectedMinutes = int.parse(reminder.time.split(':')[1]);
      controllerMinutes.jumpToItem(selectedMinutes);

      selectedReminderName = reminder.reminderName;
      selectedDay = kDaysValue[reminder.dayName];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.id != -1){
      getLesson();

    }
  }


  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      resizeToAvoidBottomPadding: false,
      title: Text('Hatirlatici'),
      body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all( 20.0),
                        child: TextField(
                          controller: TextEditingController(text: selectedReminderName),
                          style: myTitleText,
                          decoration:
                          InputDecoration(hintText: 'Aktivite adini giriniz.'),
                          onChanged: (val){
                            selectedReminderName = val;
                          },
                        ),
                      ),
                      ReusableCard(
                        cardChild: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Hangi Gun:',
                                style: myTitleText,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  style: myTitleText,
                                  hint: Text('Hangi Gun?'),
                                  value: selectedDay,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      selectedDay = newValue;

                                    });
                                  },
                                  items: kDaysValue
                                      .map<DropdownMenuItem<String>>(
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
                                childCount: 25,
                                backgroundColor: kMainBackgroundColor,
                                itemExtent: 24,
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
                  onPressed: (){
                    if (selectedReminderName == '') {
                      return MyFunctions.showMyDialog(context,
                          title: 'Aktivite adı boş olamaz!', btnText: 'Tamam');
                    }

                    DatabaseHelperReminder dbHelper = DatabaseHelperReminder();
                    dbHelper.initDb();

                    Reminder reminder = Reminder(
                        dayName: kDaysValue
                            .indexWhere((element) => element.endsWith(selectedDay)),
                        time: MyFunctions.addZero(selectedHour) +
                            ':' +
                            MyFunctions.addZero(selectedMinutes),
                        reminderName: selectedReminderName);
                    if (widget.id != -1) {
                      reminder.id = widget.id;
                      dbHelper.update(reminder);
                      Navigator.pop(context);

                      return 0;

                    }

                    dbHelper.saveReminder(reminder);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          )),
    );






  }
}
