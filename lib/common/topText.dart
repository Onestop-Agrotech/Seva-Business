import 'package:flutter/material.dart';
import 'package:sevaBusiness/constants/themeColors.dart';

class TopText extends StatelessWidget {
  final String txt;

  TopText({this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
          fontFamily: "Raleway",
          fontWeight: FontWeight.w500,
          fontSize: 20.0,
          color: ThemeColoursSeva().dkGreen),
    );
  }
}
