import '../main.dart'; // will edit
import 'package:flutter/material.dart';
import '../contants.dart';

class Bottom extends StatelessWidget {
  final Function onPressed;
  final String text;
  Bottom({this.onPressed, @required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: this.onPressed,
        child: Container(
          child: Center(
            child: Text(
              this.text,
              style: kLargeButtonTextStyle.copyWith(color: Colors.black),
            ),
          ),
          color: kYellowColor,
          margin: EdgeInsets.only(top: 10.0),
          height: kBottomHeight,
        ),
      ),
    );
  }
}
