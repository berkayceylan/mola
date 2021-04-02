import 'package:flutter/material.dart';
import 'package:yasam_kocu_orj/contants.dart';

class StatefulDialogWithCheckBox extends StatefulWidget {
  bool val;
  Function onCheckBoxChange;
  Function clickOk;
  StatefulDialogWithCheckBox({this.val, this.onCheckBoxChange, this.clickOk});

  @override
  _StatefulDialogWithCheckBoxState createState() =>
      _StatefulDialogWithCheckBoxState();
}

class _StatefulDialogWithCheckBoxState
    extends State<StatefulDialogWithCheckBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(15.0),
            color: kInactiveCardColor,
            child: Column(
              children: <Widget>[
                Text(
                    '"Mola" uygulamasının ekran kullanım süresi verilerine erişmesi için kullanım süreleri izin kısmından mola uygulamasını açmanız gerekmektedir.'),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text('Bu uyarıyı bir daha gösterme'),
                      Checkbox(
                        value: widget.val,
                        onChanged: (val) {
                          setState(() {
                            widget.val = widget.onCheckBoxChange(val);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: () async{
                    Navigator.pop(context);
                    widget.clickOk();
                  },
                  color: kYellowColor,
                  child: Text(
                    'Tamam',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
