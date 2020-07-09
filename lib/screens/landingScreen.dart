import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sevaBusiness/classes/storage_sharedPrefs.dart';
import 'package:sevaBusiness/constants/apiCalls.dart';

import 'package:flutter/material.dart';
import 'package:sevaBusiness/common/landingCard.dart';
import 'package:sevaBusiness/common/topText.dart';
import 'package:sevaBusiness/constants/themeColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

class LandingItem {
  final String name;
  final Icon icon;

  LandingItem({this.name, this.icon});
}

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool _switchValue;
  bool _onlineStatus;
  FirebaseMessaging _firebaseMessaging;

  @override
  initState() {
    super.initState();
    _switchValue = false;
    _firebaseMessaging = FirebaseMessaging();
    _getOnlineStatus();
    initFCM();
  }

  initFCM() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _serialiseAndNavigate(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _serialiseAndNavigate(message);
      },
      onResume: (Map<String, dynamic> message) async {
        // print("onResume: $message");
        _serialiseAndNavigate(message);
      },
    );
  }

  void _serialiseAndNavigate(Map<String, dynamic> message) {
    var notificationData = message['data'];
    var view = notificationData['view'];
    if (view != null) {
      // Navigate to the create post view
      if (view == 'new_order') {
        Navigator.pushNamed(context, '/orders');
      }
      // If there's no view it'll just open the app on the first view
    }
  }

  _setOnlineStatus() async {
    StorageSharedPrefs p = new StorageSharedPrefs();
    String id = await p.getId();
    String token = await p.getToken();
    Map<String, String> requestHeaders = {'x-auth-token': token};
    String url = APIService.businessOnline + "$id";
    var response = await http.put(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      // got online status
      // return json.decode(response.body);
      setState(() {
        _onlineStatus = json.decode(response.body)["online"];
        if (_onlineStatus)
          _switchValue = true;
        else
          _switchValue = false;
      });
    } else if (response.statusCode == 404) {
      // no name
      print("404 error");
    } else
      throw Exception("Server error");
  }

  _getOnlineStatus() async {
    StorageSharedPrefs p = new StorageSharedPrefs();
    String id = await p.getId();
    String token = await p.getToken();
    Map<String, String> requestHeaders = {'x-auth-token': token};
    String url = APIService.businessOnline + "$id";
    var response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      // got online status
      // return json.decode(response.body);
      setState(() {
        _onlineStatus = json.decode(response.body)["online"];
        if (_onlineStatus)
          _switchValue = true;
        else
          _switchValue = false;
      });
    } else if (response.statusCode == 404) {
      // no name
      print("404 error");
    } else
      throw Exception("Server error");
  }

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

  _switchBuilder() {
    return Switch(
      value: _switchValue,
      onChanged: (val) async {
        // do something here
        setState(() {
          // _loaderSwitch = true;
          _switchValue = val;
        });
        await _setOnlineStatus();
        _showAlert();
        // _markOutOfStock();
      },
      activeTrackColor: Colors.lightGreenAccent,
      activeColor: Colors.green,
    );
  }

  _showAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Status"),
            content: Text(_onlineStatus
                ? "Your store is now online"
                : "Your store is now offline"),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.person_pin),
          onPressed: () {
            _showLogoutOption(context);
          },
        ),
        title: TopText(
          txt: "Seva Cloud Store",
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[_switchBuilder()],
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
                        fontWeight: FontWeight.normal),
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
