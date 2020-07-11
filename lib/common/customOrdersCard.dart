import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sevaBusiness/classes/storage_sharedPrefs.dart';
import 'package:sevaBusiness/constants/themeColors.dart';
import 'package:sevaBusiness/models/orders.dart';
import 'package:sevaBusiness/screens/orderMoreDetails.dart';
import 'package:http/http.dart' as http;

class CustomOrdersCard extends StatefulWidget {
  final OrderModel order;

  CustomOrdersCard({this.order});
  @override
  _CustomOrdersCardState createState() => _CustomOrdersCardState();
}

class _CustomOrdersCardState extends State<CustomOrdersCard> {
  var _time;
  var _today;
  bool _less = false;

  @override
  void initState() {
    super.initState();
    DateTime now = new DateTime.now();
    _today = now.day;
    _time = DateTime.parse(widget.order.timestamp.toString()).toLocal();
    if (int.parse(_time.minute.toString()) < 10)
      setState(() {
        _less = true;
      });
  }

  _changeOrderStatusToReady() async {
    StorageSharedPrefs p = new StorageSharedPrefs();
    String token = await p.getToken();
    Map<String, String> requestHeaders = {'x-auth-token': token};
    String url =
        "https://api.theonestop.co.in/api/orders/${widget.order.id}/orderStatus/";
    var bodyJson = json.encode({"orderStatus": "Ready"});
    var response = await http.put(url, headers: requestHeaders, body: bodyJson);
    if (response.statusCode == 200) {
      // successfully updated order status
      print("success");
    } else if (response.statusCode == 404) {
      // no business user found
      print("404 error");
    } else if (response.statusCode == 500) {
      // internal server error
      print("500 error");
    } else {
      // throw some error exception
      print("some other error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderMoreDetails(
                order: widget.order,
              ),
            ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 200.0,
        decoration: BoxDecoration(border: Border.all()),
        // color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "No. ${widget.order.orderNumber}",
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: ThemeColoursSeva().black),
                ),
                Text(
                  _today == _time.day
                      ? "Token Number ${widget.order.tokenNumber}"
                      : "",
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 17.5,
                      fontWeight: FontWeight.w700,
                      color: ThemeColoursSeva().black),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "${_time.day}-${_time.month}-${_time.year}",
                      style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 17.0,
                          color: ThemeColoursSeva().black),
                    ),
                    SizedBox(width: 10.0),
                    _less
                        ? Text("${_time.hour}:0${_time.minute}",
                            style: TextStyle(
                                fontFamily: "Raleway",
                                fontSize: 16.0,
                                color: ThemeColoursSeva().black))
                        : Text("${_time.hour}:${_time.minute}",
                            style: TextStyle(
                                fontFamily: "Raleway",
                                fontSize: 16.0,
                                color: ThemeColoursSeva().black)),
                  ],
                ),
                SizedBox(height: 10.0),
                Text("${widget.order.orderStatus}",
                    style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 20.0,
                        color: widget.order.orderStatus == "Processing"
                            ? Colors.deepOrange
                            : ThemeColoursSeva().lgGreen)),
                widget.order.orderStatus != "finished"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Switch(
                            value: widget.order.orderStatus == "Processing"
                                ? false
                                : true,
                            onChanged: (val) {
                              // change order status here
                              setState(() {
                                // widget.order.orderStatus="Ready";
                                if (widget.order.orderStatus == "Processing")
                                  widget.order.orderStatus = "Ready";
                              });
                              // send POST request to server here
                              _changeOrderStatusToReady();
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                          Text(
                            widget.order.orderStatus == "Processing"
                                ? "Mark as PACKED"
                                : "PACKED",
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.black),
                          )
                        ],
                      )
                    : Text("Order Completed",
                        style: TextStyle(
                            fontSize: 16.0, color: ThemeColoursSeva().dkGreen)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
