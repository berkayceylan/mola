import 'package:flutter/material.dart';
class RoundedButton extends StatelessWidget {
  final child;
  final Color bgColor;
  final Function onClick;
  RoundedButton({this.child, this.bgColor, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Material(
          elevation: 5.0,
          color: this.bgColor,
          borderRadius: BorderRadius.circular(30.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: MaterialButton(
              onPressed: this.onClick,
//          minWidth: 200.0,

              child: this.child,
            ),
          ),
        ),
      ),
    );
  }
}
