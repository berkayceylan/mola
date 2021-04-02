import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class MySlidable extends StatefulWidget {
  final Widget child;
  final Function onDeleteTab;
  MySlidable({this.child, this.onDeleteTab});


  @override
  _MySlidableState createState() => _MySlidableState();
}

class _MySlidableState extends State<MySlidable> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: widget.child,
      actions: <Widget>[

      ],
      secondaryActions: <Widget>[

        IconSlideAction(
          color: Colors.red,
          icon: Icons.delete,
          onTap: widget.onDeleteTab,
        ),
      ],
    );
  }
}
