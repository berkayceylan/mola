import 'package:flutter/material.dart';
import 'package:yasam_kocu_orj/contants.dart';
class MyListItem extends StatelessWidget {

  final String title;
  final String subTitle;
  MyListItem({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: kActiveCardColor,
        child: ListTile(
          title: Text(title),
        ),
      ),
    );
  }
}
