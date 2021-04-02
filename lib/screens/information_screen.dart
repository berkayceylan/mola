import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_html/flutter_html.dart';
import 'package:yasam_kocu_orj/components/my_drawer.dart';
import 'package:yasam_kocu_orj/components/my_scaffold.dart';
import 'package:yasam_kocu_orj/contants.dart';
import 'package:yasam_kocu_orj/components/reusable_card.dart';
import 'package:flutter_html/style.dart';

class InformationScreen extends StatefulWidget {
  static final id = 'information';

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  String text = '';

  getText() async {
    String textTmp = await rootBundle
        .loadString('lib/assets/html/teknoloji_bagimliligi.html');
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
      title: Text('Teknoloji Bağımlılığı'),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Image.asset('lib/assets/temp/inf.png'),
            ),
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
