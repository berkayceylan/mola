import 'package:flutter/material.dart';
import 'package:yasam_kocu_orj/components/my_drawer.dart';
import 'package:yasam_kocu_orj/contants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yasam_kocu_orj/components/my_functions.dart';
import 'package:yasam_kocu_orj/components/my_scaffold.dart';

class FriendScreen extends StatefulWidget {
  static final id = 'friend';

  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  Map<String, double> friendsMap = {
    'Ayşe': 62,
    'Ahmet': 83,
    'Hasan': 136,
    'Ömer': 167,
    'Sevgi': 206,
    'Merve': 232,
//    'Sevda': 274,
//    'Ali': 285,
//    'Berkay': 306,
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      myLeading: Icon(
        FontAwesomeIcons.trophy,
        size: 30.0,
        color: kYellowColor,
      ),
      title: Text(
        'Arkadaşlarım',
        style: kTitleText,
      ),
      body:Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                        itemCount: friendsMap.length,
                        itemBuilder: (context, inx) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 4.0),
                            child: Card(
                              color: kActiveCardColor,
                              child: ListTile(
                                leading: Padding(
                                  padding: const EdgeInsets.only(right: 0.0),
                                  child: Icon(
                                    inx < 3 ? FontAwesomeIcons.trophy : FontAwesomeIcons.clock,
                                    size: 35.0,
                                    color: kYellowColor,
                                  ) ,
                                ),
                                title: Text(
                                  (inx+1).toString() + '. ' + friendsMap.keys.elementAt(inx),
                                  style: kTitleText.copyWith(color: kBlueColor),
                                ),
                                trailing: Text(
                                  MyFunctions.minutesToHours(friendsMap.values.elementAt(inx), 'saat', 'dk.'),
                                  style: kTextStyle.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          )),
    );







  }
}
