import 'package:flutter/material.dart';

class EnvironmentImage extends StatelessWidget {
  final String location;
  EnvironmentImage({this.location});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      location,
      width: 50.0,
    );
  }
}
