import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sevaBusiness/classes/storage_sharedPrefs.dart';
import 'package:sevaBusiness/common/topText.dart';
import 'package:sevaBusiness/constants/apiCalls.dart';
import 'package:sevaBusiness/constants/themeColors.dart';
import 'package:sevaBusiness/models/orders.dart';
import 'package:sevaBusiness/common/customOrdersCard.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _data;

  @override
  void initState() {
    super.initState();
    _data = true;
  }

  _getOrderOfUser() async {
    StorageSharedPrefs p = new StorageSharedPrefs();
    String username = await p.getUsername();
    String token = await p.getToken();
    String url = APIService.ordersListAPI + "$username";
    Map<String, String> requestHeaders = {'x-auth-token': token};
    var response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      // got orders
      return toOrdersFromJson(json.decode(response.body)["msg"]);
      // print(json.decode(response.body)["orders"] is String);
    } else if (response.statusCode == 404) {
      // no orders
      setState(() {
        _data = false;
      });
    } else
      throw Exception("Server error");
  }

  _dataOrNot() {
    if (_data == false)
      return Container(
        child: Center(
          child: Text("No Orders available!"),
        ),
      );
    else
      return Column(
        children: <Widget>[Expanded(child: _buildOrdersArray())],
      );
  }

  FutureBuilder _buildOrdersArray() {
    return FutureBuilder(
        future: _getOrderOfUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<OrderModel> ordersArr = snapshot.data;
            if (ordersArr.length > 0) {
              // sort the array according to time
              ordersArr.sort((a, b) =>
                  b.timestamp.toString().compareTo(a.timestamp.toString()));
              // build array
              return ListView.builder(
                  itemCount: ordersArr.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        CustomOrdersCard(
                          order: ordersArr[index],
                        ),
                        SizedBox(height: 30.0)
                      ],
                    );
                  });
            } else {
              return Container(
                child: Center(
                  child: Text("No Customer Order!"),
                ),
              );
            }
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: ThemeColoursSeva().black,
                  strokeWidth: 4.0,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(ThemeColoursSeva().grey),
                ),
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          title: TopText(txt: "Orders"),
          leading: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: ThemeColoursSeva().black,
                size: 40.0,
              ),
              onPressed: () {
                // go to store list
                Navigator.pop(context);
              }),
          backgroundColor: Colors.transparent,
          elevation: 0,
          // title: Center(Title: 'My Orders'),
          centerTitle: true,
        ),
      ),
      body: _dataOrNot(),
    );
  }
}
