import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sevaBusiness/classes/storage_sharedPrefs.dart';
import 'package:sevaBusiness/constants/apiCalls.dart';

import 'package:flutter/material.dart';
import 'package:sevaBusiness/common/landingCard.dart';
import 'package:sevaBusiness/common/topText.dart';
import 'package:sevaBusiness/constants/themeColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingItem {
  final String name;
  final Icon icon;

  LandingItem({this.name, this.icon});
}

class LandingScreen extends StatelessWidget {
  _getName() async {
    StorageSharedPrefs p = new StorageSharedPrefs();
    String id = await p.getId();
    String token = await p.getToken();
    String url = APIService.businessNameAPI + "$id";
    Map<String, String> requestHeaders = {'x-auth-token': token};
    var response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      // got name
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      // no name
      print("404 error");
    } else
      throw Exception("Server error");
  }

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
          txt: "Seva Cloud Store",
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
      body: Column(
        children: <Widget>[
          SizedBox(height: 40.0),
          FutureBuilder(
            future: _getName(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text("${snapshot.data}",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: ThemeColoursSeva().black,
                      fontWeight: FontWeight.normal
                    ),
                    overflow: TextOverflow.ellipsis);
              } else
                return Container();
            },
          ),
          SizedBox(height: 40.0),
          Container(
            height: 150.0,
            child: ListView.builder(
                itemCount: 2,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  // List<String> arr = ["orders", "products", "payments"];
                  List<LandingItem> items = [];
                  LandingItem orders = new LandingItem(
                      name: "orders",
                      icon: Icon(
                        Icons.view_agenda,
                        size: 40.0,
                        color: ThemeColoursSeva().dkGreen,
                      ));
                  items.add(orders);
                  LandingItem products = new LandingItem(
                      name: "products",
                      icon: Icon(
                        Icons.account_box,
                        size: 40.0,
                        color: ThemeColoursSeva().dkGreen,
                      ));
                  items.add(products);
                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: <Widget>[
                        LandingCard(
                          landingName: items[index].name,
                          icon: items[index].icon,
                        ),
                        SizedBox(width: 20.0)
                      ],
                    ),
                  );
                }),
          ),
          SizedBox(height: 30.0),
          // Row(
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.only(left: 20.0),
          //       child: Container(
          //         height: 150.0,
          //         child: LandingCard(
          //             landingName: "payments",
          //             icon: Icon(
          //               Icons.payment,
          //               size: 40.0,
          //               color: ThemeColoursSeva().dkGreen,
          //             )),
          //       ),
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}
