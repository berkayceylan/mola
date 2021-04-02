import 'package:flutter/material.dart';
import '../contants.dart';


const iconSize = 80.0;
const margin = 15.0;

class TextCard extends StatelessWidget {
  final String text;
  final IconData icon;
  TextCard(this.text,  this.icon);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: iconSize,
        ),
        SizedBox(
          height: margin,
        ),
        Text(
          this.text,
          style: kTextStyleWhite,
        ),
      ],
    );
  }
}