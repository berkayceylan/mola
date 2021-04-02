import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:yasam_kocu_orj/components/reusable_card.dart';
import 'package:yasam_kocu_orj/contants.dart';
import 'package:yasam_kocu_orj/components/my_functions.dart';

TextStyle myTitleText = kTitleText.copyWith(fontWeight: FontWeight.normal);

class CupertinoNumberGenerator extends StatefulWidget {
  final int count;
  final Function onChange;
  final int initialItem;
  final FixedExtentScrollController controller;
  CupertinoNumberGenerator(
      {@required this.count, @required this.onChange, this.initialItem = 4, this.controller});
  @override
  _CupertinoNumberGeneratorState createState() =>
      _CupertinoNumberGeneratorState();
}

class _CupertinoNumberGeneratorState extends State<CupertinoNumberGenerator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: CupertinoPicker(
        backgroundColor: kMainBackgroundColor,
        itemExtent: 30,

        scrollController: widget.controller,
        children: List.generate(widget.count, (inx) {
          return Text(
            MyFunctions.addZero(inx),
            style: TextStyle(color: Colors.white),
          );
        }),
        onSelectedItemChanged: widget.onChange,
      ),
    );
  }
}

class TimeSelector extends StatefulWidget {
  Function onSelectMinutes;
  Function onSelectHour;
  final int initialItemHour;
  final int initialItemMinutes;

  final FixedExtentScrollController hourController;
  TimeSelector(
      {this.onSelectMinutes,
      this.onSelectHour,
      this.initialItemHour = 10,
      this.initialItemMinutes = 10, this.hourController});
  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      cardChild: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Saat: ',
                style: myTitleText,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoNumberGenerator(
                count: 25,
                onChange: widget.onSelectHour,
                initialItem: widget.initialItemHour,
                controller: widget.hourController,
              ),
            ),
          ),
          Text(
            ':',
            style: myTitleText,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoNumberGenerator(
                count: 61,
                onChange: widget.onSelectMinutes,
                initialItem: widget.initialItemMinutes,
                controller: widget.hourController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// CupertinoPicker.builder(
// backgroundColor: kMainBackgroundColor,
// itemExtent: 30,
// scrollController: FixedExtentScrollController(
// initialItem: widget.initialItem,
// ),
// itemBuilder: (context, inx) {
// return Text(
// MyFunctions.addZero(inx),
// style: TextStyle(color: Colors.white),
// );
// },
// onSelectedItemChanged: widget.onChange,
// ),