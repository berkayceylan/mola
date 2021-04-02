import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yasam_kocu_orj/components/my_drawer.dart';
import 'package:yasam_kocu_orj/components/slider_content.dart';
import 'package:yasam_kocu_orj/components/reusable_card.dart';
import 'package:yasam_kocu_orj/components/rounded_button.dart';
import 'package:yasam_kocu_orj/contants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yasam_kocu_orj/components/my_functions.dart';
import 'package:yasam_kocu_orj/components/my_scaffold.dart';

class GoalsScreen extends StatefulWidget {
  static String id = 'myGoals';
  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  double selectedScreenOnTime = 180;
  double selectedScreenUnlock = 20;
  SharedPreferences prefs;

  loadData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedScreenOnTime = prefs.getDouble(kGoalsScreenOnKey) ?? 120;
      selectedScreenUnlock = prefs.getDouble(kGoalsScreenUnlockKey) ?? 30;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: Text('Hedeflerim'),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ReusableCard(
              myColor: kActiveCardColor,
              cardChild: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: SliderContent(
                  title: 'Hedeflediğiniz kullanım süresi?',
                  val: selectedScreenOnTime,
                  viewVal: MyFunctions.minutesToHours(
                      selectedScreenOnTime, 'Saat', 'Dakika'),
                  minValue: 60,
                  division: 14,
                  maxValue: 480,
                  theme: blueTheme,
                  onChange: (val) {
                    prefs.setDouble(kGoalsScreenOnKey, val);

                    setState(() {
                      selectedScreenOnTime = val;
                    });
                  },
                ),
              ),
            ),
            ReusableCard(
              myColor: kActiveCardColor,
              cardChild: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Column(
                  children: <Widget>[
                    SliderContent(
                      title: 'Hedeflediğiniz kilit açma sayısı?',
                      val: selectedScreenUnlock,
                      sliderType: 'adet',
                      theme: yellowTheme,
                      minValue: 0,
                      maxValue: 100,
                      onChange: (val) {
                        prefs.setDouble(kGoalsScreenUnlockKey, val);

                        setState(() {
                          selectedScreenUnlock = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            RoundedButton(
              child: Text(
                'Kaydet',
                style: TextStyle(
                  color: Color(0XFF192D3A),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onClick: (){
                Fluttertoast.showToast(
                    msg: "Kaydedildi",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: kRedColor,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              },
              bgColor: Color(0xFFFEAC3E),
            )
          ],
        ),
      ),
    );
  }
}
