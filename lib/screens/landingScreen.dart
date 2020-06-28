import 'package:flutter/material.dart';
import 'package:sevaBusiness/common/landingCard.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200.0,
          child: ListView.builder(
              itemCount: 2,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: <Widget>[
                      LandingCard(),
                      SizedBox(width:20.0)
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
