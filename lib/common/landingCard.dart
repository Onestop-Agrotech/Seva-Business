import 'package:flutter/material.dart';

class LandingCard extends StatelessWidget {
  final String landingName;
  LandingCard({this.landingName});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/$landingName');
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.grey)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              landingName == 'orders' ? Icon(Icons.view_agenda): Icon(Icons.account_box),
              Text("$landingName")
            ],
          ),
        ),
      ),
    );
  }
}
