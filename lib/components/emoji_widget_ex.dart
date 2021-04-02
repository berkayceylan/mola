import 'package:flutter/material.dart';
import 'package:yasam_kocu_orj/contants.dart';
import 'package:yasam_kocu_orj/components/reusable_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmojiWidgetEx extends StatefulWidget {
  @override
  _EmojiWidgetExState createState() => _EmojiWidgetExState();
}

class _EmojiWidgetExState extends State<EmojiWidgetEx> {
  int rowItems = 0;
  int lastRowItems = 0;
  int columnCount = 2;

  List<Widget> emojiTable() {
    List<Widget> listRow = List(); //son satirdan oncekiler
    List<Widget> lastListRow = List(); //son satir
    List<Widget> mainList = List();
    for (var i = 0; i < columnCount; i++) {
      mainList.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            rowItems,
                (i) {
              return Icon(
                FontAwesomeIcons.smileBeam,
                color: blueTheme.primaryColor,
                size: 45.0,
              );
            },
          ),
        ),
      );
    }


    mainList.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          lastRowItems,
          (i) {
            return Icon(
              FontAwesomeIcons.smileBeam,
              color: blueTheme.primaryColor,
              size: 45.0,
            );
          },
        ),
      ),
    );

    return mainList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final children = <Widget>[];
    for (var i = 0; i < 4; i++) {
      children.add(
        Icon(
          FontAwesomeIcons.smileBeam,
          color: blueTheme.primaryColor,
          size: 85.0,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      myColor: kActiveCardColor,
      cardChild: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: emojiTable(),
      ),
    );
  }
}
