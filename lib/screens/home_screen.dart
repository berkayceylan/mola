import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screen_state/screen_state.dart';
import 'package:yasam_kocu_orj/components/stateful_dialog_with_checkbox.dart';
import 'package:yasam_kocu_orj/components/my_scaffold.dart';
import 'package:yasam_kocu_orj/components/people_widget.dart';
import 'package:yasam_kocu_orj/contants.dart';
import 'package:yasam_kocu_orj/components/text_area.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_usage/app_usage.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences prefs;

  int firstColumn = 3;
  int secondColumn = 2;
  int thirdColumn = 3;
  int decreasePeople = 0;

  int totalPeople = 8;

  double selectedScreenOnTime = 120;
  double selectedScreenUnlock = 20;
  int unlockScreenAmount = 1;
  double minutesOfUsage = 0;
  double millisecondsOfUsage = 0;

  void getUsageStats() async {
    try {
      DateTime endDate = new DateTime.now();

      DateTime startDate = DateTime(endDate.year, endDate.month, endDate.day);
      List<AppUsageInfo> infos = await AppUsage.getAppUsage(startDate, endDate);

      for (int i = 0; i < kListBannedPackages.length; i++) {
        for (int j = 0; j < infos.length; j++) {
          if (infos.elementAt(j).appName == kListBannedPackages.elementAt(i)) {
            infos.removeAt(j);
          }
        }
      }

      var tempLength = prefs.getStringList(kScreenOnAppListKey) == null
          ? 0
          : prefs.getStringList(kScreenOnAppListKey).length;

      for (int i = 0; i < tempLength; i++) {
        for (int j = 0; j < infos.length; j++) {
          if (infos.elementAt(j).appName ==
              prefs.getStringList(kScreenOnAppListKey).elementAt(i)) {
            infos.removeAt(j);
          }
        }
      }

      for (var i = 0; i < infos.length; i++) {
        setState(() {
          minutesOfUsage += infos.elementAt(i).usage.inMinutes;
        });
      }

      setPeopleCount();
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  String kDontShowAgainKey = 'dontShowAgain';
  bool dontShowAgain = false;

  Future<bool> getAllGoalsData() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getInt(kUnlockScreenAmountKey) == null) {
      prefs.setInt(kUnlockScreenAmountKey, 0);
    }

    setState(() {
      selectedScreenOnTime = prefs.getDouble(kGoalsScreenOnKey) ?? 120;
      selectedScreenUnlock = prefs.getDouble(kGoalsScreenUnlockKey) ?? 30;
    });

    // showPermissionDialog();
    if(prefs.getBool(kDontShowAgainKey) == null || !prefs.getBool(kDontShowAgainKey)){
      await showDialog(
          context: context,
          builder: (context) {
            return StatefulDialogWithCheckBox(
              val: dontShowAgain,
              onCheckBoxChange: (val){
                this.dontShowAgain = !this.dontShowAgain;
                print(this.dontShowAgain);
                return this.dontShowAgain;

              },
              clickOk: (){
                prefs.setBool(kDontShowAgainKey, this.dontShowAgain);
              },
            );
          });
    }



      return true;


  }

  setPeopleCount() {
    //getUsageData fonksiyonunda kullanildi
    int decrease = 0;
    int screenOnTimeTmp =
        ((minutesOfUsage - selectedScreenOnTime.toInt()) ~/ 10);

    int screenUnlockTmp =
        (unlockScreenAmount - selectedScreenUnlock.toInt()).toInt();

    decrease = ((screenOnTimeTmp < 0 ? 0 : screenOnTimeTmp) +
        (screenUnlockTmp < 0 ? 0 : screenUnlockTmp));

    for (int i = 0; i < decrease; i++) {
      setState(() {
        if (thirdColumn > 0) {
          thirdColumn--;
        } else if (secondColumn > 0) {
          secondColumn--;
        } else if (firstColumn > 0) {
          firstColumn--;
        }
      });
    }
  }

  Screen _screen = Screen();
  StreamSubscription<ScreenStateEvent> _subscription;
  bool started = false;
  String kCurrentDay = 'currentDay';
  void startListening() {
    DateTime now = DateTime.now();
    if(prefs.getInt(kCurrentDay) == null){

      prefs.setInt(kCurrentDay, now.day);
    }else if(prefs.getInt(kCurrentDay) != now.day){
      prefs.setInt(kCurrentDay, now.day);

      setState(() {
        prefs.setInt(kUnlockScreenAmountKey, 0);
      });

    }


    try {
      _subscription = _screen.screenStateStream.listen((event) {
        print('event');
        if (event == ScreenStateEvent.SCREEN_UNLOCKED) {
          setState(() {
            prefs.setInt(kUnlockScreenAmountKey,
                (prefs.getInt(kUnlockScreenAmountKey) + 1) ?? 0);
          });
        }
      });
      prefs.setBool('unlockState', true);
    } on ScreenStateException catch (exception) {
      print(exception);
    }
  }

  setUnlockState() async {
    prefs = await SharedPreferences.getInstance();

    if (!started) startListening();

    unlockScreenAmount = prefs.getInt(kUnlockScreenAmountKey) ?? 0;
  }
  void myInitFunc() async{
    await getAllGoalsData();
    getUsageStats();
    setUnlockState();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myInitFunc();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //_lockButtonSubscription?.cancel(); //Degisebilir
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: Text('Anasayfa Deneme'),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PeopleWidget(
                firstRowCount: firstColumn,
                secondRowCount: secondColumn,
                thirdRowCount: thirdColumn,
              ),
            ),
            Expanded(
              // Bottom
              flex: 2,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextArea(
                            titleText: 'Ekran Kullanımı',
                            amount: (minutesOfUsage ~/ 60).toString(),
                            amountType: 'saat',
                            amount2: (minutesOfUsage % 60).toInt().toString(),
                            amountType2: 'dk.',
                          ),
                        ),
                        Expanded(
                          child: TextArea(
                            titleText: 'Kilit Açma',
                            amount: unlockScreenAmount.toString(),
                            amountType: 'adet',
                            amount2: '',
                            amountType2: '',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextArea(
                            titleText: 'Hedef',
                            amount: (selectedScreenOnTime ~/ 60).toString(),
                            amountType: 'saat',
                            amount2:
                                (selectedScreenOnTime % 60).toInt().toString(),
                            amountType2: 'dk.',
                          ),
                        ),
                        Expanded(
                          child: TextArea(
                            titleText: 'Hedef',
                            amount: selectedScreenUnlock.toInt().toString(),
                            amountType: 'adet',
                            amount2: '',
                            amountType2: '',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
