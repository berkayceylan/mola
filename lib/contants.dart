import 'package:flutter/material.dart';
// import 'package:locally/src/helpers.dart';
const kAppName = 'Mola';

const kTextStyle = TextStyle(
  color: Color(0xFF8D8E98),
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
);
const kTextStyleWhite = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
);
const kTitleText = TextStyle(
  color: Colors.white,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);
const kTitleBlack = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
);
const kLargeButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);
const kResultStatusTextStyle = TextStyle(
  fontSize: 27.0,
  fontWeight: FontWeight.bold,
  color: Colors.green,
);
const kBMITextStyle = TextStyle(
  fontSize: 87.0,
  fontWeight: FontWeight.bold,
);
const kBottomHeight = 80.0;

const kActiveCardColor = Color(0xFF1D1E33);
const kInactiveCardColor = Color(0xFF111328);

const kYellowColor = Color(0xFFFEAC3E);
const kBlueColor = Color(0xFF4FC9F0);
const kRedColor = Color(0xFFEB1555);
const kMainBackgroundColor = Color(0xff090C22);



const kScreenOnAppListKey = 'screenOnAppList';
const kGoalsScreenOnKey = 'screenOn';
const kGoalsScreenUnlockKey = 'screenUnlock';
const kUnlockScreenAmountKey = 'screenAmount';

ThemeData redTheme = ThemeData(
  primaryColor: Color(0xFFEB1555),
  backgroundColor: Color(0x55EB1555),
);

ThemeData yellowTheme = ThemeData(primaryColor: Color(0xFFFEAC3E));

ThemeData blueTheme = ThemeData(primaryColor: Color(0xFF4FC9F0));

List<String> kDaysKey = ['pazartesi', 'sali', 'carsamba', 'persembe', 'cuma', 'cumartesi', 'pazar'];
List<String> kDaysValue = ['Pazartesi', 'Salı', 'Çarşamba', 'Perşembe', 'Cuma', 'Cumartesi', 'Pazar'];

List<String> kListBannedPackages = [
  'gms', 'katana',
  'settings', 'incallui',
  'galaxyfinder', 'systemui', 'vending',
  'launcher', 'lool', 'android',
  'nexuslauncher', 'permissioncontroller'];