import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:yasam_kocu_orj/components/my_drawer.dart';
import 'package:yasam_kocu_orj/contants.dart';
import 'package:yasam_kocu_orj/components/reusable_card.dart';
import 'package:yasam_kocu_orj/components/my_scaffold.dart';

class ActivityRecommendScreen extends StatefulWidget {
  static final id = 'recommend';
  @override
  _ActivityRecommendScreenState createState() =>
      _ActivityRecommendScreenState();
}

class _ActivityRecommendScreenState extends State<ActivityRecommendScreen> {
  String text = '';

  getText() async {
    String textTmp =
        await rootBundle.loadString('lib/assets/html/etkinlik_onerileri.html');
    setState(() {
      text = textTmp;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getText();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: Text('Etkinlik Önerileri'),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, top: 18.0, right: 18.0),
                child: SingleChildScrollView(
                  child: Html(
                    data: text,
                    style: {
                      "html": Style(
                        fontSize: FontSize.large,
                        lineHeight: 55.0,
                      )
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
