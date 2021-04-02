import 'package:flutter/material.dart';
import 'package:yasam_kocu_orj/components/bottom.dart';
import 'package:yasam_kocu_orj/components/my_drawer.dart';
import 'package:yasam_kocu_orj/components/my_functions.dart';
import 'package:yasam_kocu_orj/components/my_scaffold.dart';
import 'package:yasam_kocu_orj/components/my_slidable.dart';
import 'package:yasam_kocu_orj/contants.dart';
import 'package:yasam_kocu_orj/database/database_helper_reminder.dart';
import 'package:yasam_kocu_orj/database/model/reminder.dart';
import 'package:yasam_kocu_orj/screens/input_reminder.dart';

class ReminderScreen extends StatefulWidget {
  static final id = 'reminder';
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  List<Reminder> reminders;
  DatabaseHelperReminder dbHelper = DatabaseHelperReminder();
  Map<String, List<Reminder>> remindersDayByDay = Map();

  List<Reminder> allReminders = List();



  getAllReminders() async {
    List<Reminder> allRemindersTmp = await dbHelper.getAllReminder();
    setState(() {
      allReminders = allRemindersTmp;
    });

    dbHelper.setNotification(context);
  }

  void initState() {
    // TODO: implement initState
    for (int i = 0; i < kDaysKey.length; i++) {
      remindersDayByDay[kDaysKey[i]] = [];
    }
    super.initState();

    getAllReminders();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: Text('Hatırlatıcı'),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: List.generate(allReminders.length, (index) {
                    //Get detail of reminder
                    Reminder reminder = allReminders[index];
                    String reminderName = reminder.reminderName;
                    String time = reminder.time;
                    int id = reminder.id;
                    int dayInx = reminder.dayName;
                    return MySlidable(
                      onDeleteTab: () async {
                        await MyFunctions.showAlertDialog(context, () {
                          setState(() {
                            dbHelper.deleteReminderById(id);
                            getAllReminders();
                          });
                          Navigator.pop(context);
                        });
                      },
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InputReminder(
                                        id: id,
                                      )));
                          getAllReminders();
                        },
                        onLongPress: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: Card(
                            color: kInactiveCardColor,
                            child: ListTile(
                              title: Text(reminderName ?? ''),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    kDaysValue[dayInx] + '  -  ',
                                    style: TextStyle(color: kRedColor),
                                  ),
                                  Text(
                                    time,
                                    style: TextStyle(color: kYellowColor),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Bottom(
                text: 'Yeni Kayıt',
                onPressed: () async {
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => InputReminder()));
                  getAllReminders();
                },
              ),
            ],
          ),
        ),
      ),
    );

    Scaffold(
      appBar: AppBar(
        title: Text(kAppName + ' - Hatirlatici'),
      ),
      drawer: MyDrawer(),
    );
  }
}
