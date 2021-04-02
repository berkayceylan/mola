import 'package:flutter/material.dart';

class MyFunctions {
  static String minutesToHours(
      double minutes, String hoursType, String minutesType) {
    String tempStr = '';
    double hours = minutes / 60;
    double finalMinutes = minutes % 60;
    if (hours != 0) {
      tempStr += hours.toInt().toString() + ' ' + hoursType + ' ';
    }
    tempStr += addZero(finalMinutes.toInt()).toString() + ' ' + minutesType;

    return tempStr;
  }

  static int timeOutScreenOn(usageAmount, goalAmount) {
    if (usageAmount < goalAmount) return 0;

    return (usageAmount - goalAmount) ~/ 15;
  }

  static String addZero(int number) {
    if (number < 10) {
      return '0' + number.toString();
    } else {
      return number.toString();
    }
  }

  static Future<void> showMyDialog(BuildContext context,
      {String title, String btnText}) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(btnText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static showAlertDialog(BuildContext context, Function yesButtonClick) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Evet"),
      onPressed: yesButtonClick,
    );
    Widget continueButton = FlatButton(
      child: Text("Hayır"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Onay"),
            content: Text("Silmek istediğinize emin misiniz:"),
            actions: [
              cancelButton,
              continueButton,
            ],
          );
        });
  }
  static int getFirstMonday(){
    int firstMonday = 1;
    DateTime thisMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
    print('weekday ' + thisMonth.weekday.toString());
    while(firstMonday != thisMonth.weekday){
      thisMonth =  thisMonth.add(Duration(days: 1));
    }
    firstMonday = thisMonth.day;
    return firstMonday;
  }

}
