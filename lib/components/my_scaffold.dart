import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yasam_kocu_orj/components/my_drawer.dart';
import 'package:yasam_kocu_orj/screens/home_screen.dart';

class MyScaffold extends StatelessWidget {
  final Widget title;
  final Widget body;
  final Widget myLeading;
  final bool resizeToAvoidBottomPadding;
  static const emptyWidget = SizedBox();

  MyScaffold(
      {this.title,
      this.body,
      this.myLeading,
      this.resizeToAvoidBottomPadding = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: this.resizeToAvoidBottomPadding,
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Container(
              transform: Matrix4.translationValues(-20.0, 0.0, 0.0),
              child: IconButton(
                icon: Icon(FontAwesomeIcons.chevronLeft),
                onPressed: () {
                  try {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  } on Exception catch (ex) {
                    Navigator.pushNamed(context, HomeScreen.id);
                  }
                },
              ),
            ),
            Padding(
              padding: myLeading == null
                  ? const EdgeInsets.only(right: 0.0)
                  : const EdgeInsets.only(right: 15.0),
              child: myLeading,
            ),
            title,
          ],
        ),
      ),
      body: body,
    );
  }
}
