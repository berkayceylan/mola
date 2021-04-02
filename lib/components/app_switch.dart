import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yasam_kocu_orj/contants.dart';

class AppSwitch extends StatefulWidget {
  final String appName;
  AppSwitch({this.appName});
  @override
  _AppSwitchState createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  bool isSwitched = false;
  SharedPreferences prefs;
  void getPrefInstance() async {

    prefs = await SharedPreferences.getInstance();
    List<String> appList = prefs.getStringList(kScreenOnAppListKey) ?? [];

    for (int i = 0; i < appList.length; i++) {
      if (appList[i] == widget.appName.trim()) {
        setState(() {
          isSwitched = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getPrefInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
      child: Card(
        color: kActiveCardColor,
        child: ListTile(
          trailing: Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });

              if (isSwitched) {
                List<String> appList =
                    prefs.getStringList(kScreenOnAppListKey) ?? List();

                appList.add(widget.appName);
                prefs.setStringList(kScreenOnAppListKey, appList);

                print(prefs.getStringList(kScreenOnAppListKey));
              } else {
                List<String> appList =
                    prefs.getStringList(kScreenOnAppListKey) ?? List();
                appList.removeWhere((item) => item == widget.appName);

                prefs.setStringList(kScreenOnAppListKey, appList);

              }
            },
            activeTrackColor: kYellowColor,
            activeColor: kBlueColor,
          ),
          leading: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              FontAwesomeIcons.microchip,
              size: 35.0,
              color: kYellowColor,
            ),
          ),
          title: Text(
            widget.appName,
            style: kTitleText.copyWith(color: kBlueColor),
          ),
        ),
      ),
    );
  }
}
