import 'package:flutter/material.dart';
import 'package:sevaBusiness/common/landingCard.dart';
import 'package:sevaBusiness/common/topText.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TopText(
          txt: "Fruits and Vegetables Store",
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          Icon(
            Icons.person,
            color: Colors.black,
          )
        ],
      ),
      body: Center(
        child: Container(
          height: 150.0,
          child: ListView.builder(
              itemCount: 2,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                List<String> arr = ["orders", "products"];
                return Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: <Widget>[
                      LandingCard(
                        landingName: arr[index],
                      ),
                      SizedBox(width: 20.0)
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
