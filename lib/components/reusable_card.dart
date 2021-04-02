import "package:flutter/material.dart";

const marginVal = EdgeInsets.all(10.0);
final borderRadius = BorderRadius.circular(10.0);

class ReusableCard extends StatelessWidget {
  final Color myColor;
  final Widget cardChild;
  final Function onTap;
  ReusableCard({@required this.myColor, @required this.cardChild, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        child: Center(child: this.cardChild),
        margin: marginVal,
        decoration:
            BoxDecoration(color: this.myColor, borderRadius: borderRadius),
      ),
    );
  }
}
