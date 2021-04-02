import 'package:flutter/material.dart';
import 'package:yasam_kocu_orj/contants.dart';

const minValue = 1.0;
const maxValue = 15.0;

class SliderContent extends StatefulWidget {
  final String title;
  final Function onChange;
  final double val;
  final String sliderType;
  final ThemeData theme;
  final double minValue;
  final double maxValue;
  final String viewVal;
  final int division;
  SliderContent(
      {this.title,
      this.onChange,
      this.val,
      this.theme,
      this.minValue,
      this.maxValue,
      this.viewVal,
        this.division,
      this.sliderType = ''});
  @override
  _SliderContentState createState() => _SliderContentState();
}

class _SliderContentState extends State<SliderContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.title,
            style: kTextStyle,
          ),
          SizedBox(height: 8.0),
          Text(
            (widget.viewVal ?? widget.val.toInt().toString()) +
                " " +
                widget.sliderType,
            style: kTitleText,
          ),
          SliderTheme(
            data: SliderThemeData(
              inactiveTrackColor: Color(0xFF8D8E98),
              thumbColor: widget.theme.primaryColor,
              activeTrackColor: widget.theme.primaryColor,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
              overlayColor: Color(0x29EB1555),
            ),
            child: Slider(
              onChanged: widget.onChange,
              min: widget.minValue,
              max: widget.maxValue,
              divisions: widget.division ?? widget.maxValue.toInt(),
              value: widget.val.toDouble(),

            ),
          )
        ]);
  }
}
