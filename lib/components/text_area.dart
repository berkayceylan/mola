import 'package:flutter/material.dart';
import 'package:yasam_kocu_orj/contants.dart';
import 'package:yasam_kocu_orj/components/reusable_card.dart';

class TextArea extends StatelessWidget {
  final String titleText;
  final String amountType;
  final String amount;
  final String amount2;
  final String amountType2;
  TextArea(
      {this.titleText,
      this.amount,
      this.amountType,
      this.amount2,
      this.amountType2});
  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      myColor: kActiveCardColor,
      cardChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              this.titleText,
              style: kTitleText.copyWith(color: kYellowColor),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                this.amount,
                style: kTextStyle.copyWith(color: kBlueColor, fontSize: 25.0),
              ),
              Text(
                ' ' + this.amountType + ' ',
                style: kTextStyle.copyWith(color: Colors.white),
              ),
              Text(
                this.amount2 ?? '',
                style: kTextStyle.copyWith(color: kBlueColor, fontSize: 25.0),
              ),
              Text(
                ' ' + this.amountType2 ?? '',
                style: kTextStyle.copyWith(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
