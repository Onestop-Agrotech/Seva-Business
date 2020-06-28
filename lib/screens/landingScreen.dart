import 'package:flutter/material.dart';
import 'package:sevaBusiness/common/landingCard.dart';
import 'package:sevaBusiness/common/topText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreen extends StatelessWidget {
  _showLogoutOption(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Logout from App'),
            content: Text('You will not be shown to customers.'),
            actions: <Widget>[
              RaisedButton(
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.clear();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/signIn', (Route<dynamic> route) => false);
                  },
                  child: Text("LOGOUT")),
            ],
          );
        });
  }

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
          IconButton(
            icon: Icon(Icons.person_pin),
            onPressed: () {
              _showLogoutOption(context);
            },
          ),
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
