import 'package:flutter/material.dart';

class LandingCard extends StatelessWidget {
  final String landingName;
  final Icon icon;
  LandingCard({this.landingName, this.icon});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/$landingName');
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              icon,
              Text(
                "${landingName[0].toUpperCase()}${landingName.substring(1)}",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
