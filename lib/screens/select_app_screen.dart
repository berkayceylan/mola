import 'package:flutter/material.dart';
import 'package:yasam_kocu_orj/components/app_switch.dart';
import 'package:yasam_kocu_orj/contants.dart';
import 'package:app_usage/app_usage.dart';
import 'package:yasam_kocu_orj/components/my_scaffold.dart';

class SelectAppScreen extends StatefulWidget {
  static final id = 'selectApp';
  @override
  _SelectAppScreenState createState() => _SelectAppScreenState();
}

class _SelectAppScreenState extends State<SelectAppScreen> {
  List<Widget> appListWidget = List();
  List<String> appList = List();

  void getAppNames() async {
    try {
      DateTime startDate = DateTime(2020, 1, 1, 0, 0);
      DateTime endDate = new DateTime.now();
      List<AppUsageInfo> infos = await AppUsage.getAppUsage(startDate, endDate);
      for(int i = 0; i<kListBannedPackages.length; i++){
        for(int j = 0; j < infos.length; j++){
          if(infos.elementAt(j).appName == kListBannedPackages.elementAt(i)){
            infos.removeAt(j);
          }
        }
      }


      for (var i = 0; i < infos.length; i++) {
        appList.add(infos[i].appName);
      }

      setState(() {
        appList.sort();
      });
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getAppNames();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: Text('Yoksayilan uygulamalar'),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                    itemCount: appList.length,
                    itemBuilder: (BuildContext context, int itemIndex) {
                      return AppSwitch(
                        appName: appList[itemIndex],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
