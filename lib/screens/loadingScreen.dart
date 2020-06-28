import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sevaBusiness/classes/storage_sharedPrefs.dart';
import 'package:sevaBusiness/constants/apiCalls.dart';
import 'package:sevaBusiness/constants/themeColors.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  initState() {
    super.initState();
    __checkForUserToken();
  }

  _sendReqToServer(token) async {
    String url = APIService.mainTokenAPI;
    Map<String, String> headers = {"Content-Type": "application/json"};
    var body = json.encode({"token": token});
    var response = await http.post(url, body: body, headers: headers);
    if (response.statusCode == 200) {
      // valid token
      Navigator.pushReplacementNamed(context, '/landing');
    } else if (response.statusCode == 401) {
      // invalid token
      Navigator.pushReplacementNamed(context, '/signIn');
    } else if (response.statusCode == 500) {
      // internal server error
      throw Exception('Server Error');
    } else {
      throw Exception('Unknown Error');
    }
  }

  __checkForUserToken() async {
    StorageSharedPrefs p = new StorageSharedPrefs();
    String token = await p.getToken();
    if (token != '' || token != null) {
      // there is a token, now verify
      _sendReqToServer(token);
    } else {
      // no token, so just move to login screen
      Navigator.pushReplacementNamed(context, '/signIn');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: ThemeColoursSeva().black,
            strokeWidth: 4.0,
            valueColor: AlwaysStoppedAnimation<Color>(ThemeColoursSeva().grey),
          ),
        ),
      ),
    );
  }
}
