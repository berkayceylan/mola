import 'package:flutter/material.dart';
import 'reusable_card.dart';
import 'package:yasam_kocu_orj/contants.dart';
import 'package:yasam_kocu_orj/components/environment_image.dart';

class PeopleWidget extends StatefulWidget {
  //int count -> count / 2 yapilacak
  final int firstRowCount;
  final int secondRowCount;
  final int thirdRowCount;

  PeopleWidget(
      {@required this.firstRowCount,
      @required this.secondRowCount,
      @required this.thirdRowCount});

  @override
  _PeopleWidgetState createState() => _PeopleWidgetState();
}

class _PeopleWidgetState extends State<PeopleWidget> {
  @mustCallSuper
  void initState() {
    super.initState();
  }

  List<Widget> firstRow(int count) {
    List<Widget> list = List();

    for (int i = 0; i < count; i++) {
      list.add(EnvironmentImage(
        location: 'lib/assets/cevre/' + (i + 1).toString() + '.png',
      ));
    }
    return list;
  }

  List<Widget> secondRow(int count) {
    List<Widget> list = List();
    if (count == 0) {
      list = [
        EnvironmentImage(
          location: 'lib/assets/cevre/empty.png',
        ),
        Image.asset(
          'lib/assets/cocuk.png',
          width: 120,
        ),
        EnvironmentImage(
          location: 'lib/assets/cevre/empty.png',
        ),
      ];
    }
    if (count == 1) {
      list = [
        EnvironmentImage(
          location: 'lib/assets/cevre/4.png',
        ),
        Image.asset(
          'lib/assets/cocuk.png',
          width: 120,
        ),
        EnvironmentImage(
          location: 'lib/assets/cevre/empty.png',
        ),
      ];
    }

    if (count == 2) {
      list = [
        EnvironmentImage(
          location: 'lib/assets/cevre/4.png',
        ),
        Image.asset(
          'lib/assets/cocuk.png',
          width: 120,
        ),
        EnvironmentImage(
          location: 'lib/assets/cevre/5.png',
        ),
      ];
    }

    return list;
  }

  List<Widget> thirdRow(int count) {
    List<Widget> list = List();

    for (int i = 0; i < count; i++) {
      list.add(EnvironmentImage(
        location: 'lib/assets/cevre/' + (5 + i + 1).toString() + '.png',
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      myColor: kActiveCardColor,
      cardChild: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: firstRow(widget.firstRowCount),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: secondRow(widget.secondRowCount),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: thirdRow(widget.thirdRowCount),
          ),
        ],
      ),
    );
  }
}
