import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sevaBusiness/classes/storage_sharedPrefs.dart';
import 'package:sevaBusiness/common/orderDetails.dart';
import 'package:sevaBusiness/common/topText.dart';
import 'package:sevaBusiness/constants/apiCalls.dart';
import 'package:sevaBusiness/constants/themeColors.dart';
import 'package:sevaBusiness/models/orders.dart';
import 'package:http/http.dart' as http;

class OrderMoreDetails extends StatefulWidget {
  final OrderModel order;
  OrderMoreDetails({this.order});
  @override
  _OrderMoreDetailsState createState() => _OrderMoreDetailsState();
}

class _OrderMoreDetailsState extends State<OrderMoreDetails> {
  bool _loading = false;

  _loader(setState) {
    if (_loading)
      return CircularProgressIndicator();
    else
      return _showOTPField(setState);
  }

  _confirmOrderWithOTP(otp) async {
    StorageSharedPrefs p = new StorageSharedPrefs();
    String token = await p.getToken();
    Map<String, String> requestHeaders = {
      'x-auth-token': token,
      "Content-Type": "application/json"
    };
    String url = APIService.confirmOrderAPI;
    var jsonBody = json.encode({"orderId": "${widget.order.id}", "otp": otp});
    var response =
        await http.post(url, headers: requestHeaders, body: jsonBody);
    setState(() {
      _loading = false;
    });
    if (response.statusCode == 200) {
      // successful
      setState(() {
        widget.order.orderStatus = "finished";
      });
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Order Finished"),
              content: Text('You have succesfully finished an order.'),
              actions: <Widget>[
                RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/orders', ModalRoute.withName('/landing'));
                    },
                    child: Text("OK")),
              ],
            );
          });
    } else if (response.statusCode == 401) {
      // incorrect otp
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Incorrect OTP"),
              content: Text('Please renter otp.'),
              actions: <Widget>[
                RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK")),
              ],
            );
          });
    } else if (response.statusCode == 404) {
      // invalid order id
      print("invalid order id");
    } else if (response.statusCode == 500) {
      // internal server error
      print("internal server error");
    } else {
      // some other error
      print("some other error");
    }
  }

  _showOTPField(setState) {
    if (widget.order.orderStatus == "Ready") {
      return OTPTextField(
        length: 6,
        width: MediaQuery.of(context).size.width,
        fieldWidth: 30,
        style: TextStyle(fontSize: 20),
        textFieldAlignment: MainAxisAlignment.spaceAround,
        fieldStyle: FieldStyle.underline,
        onCompleted: (pin) {
          _confirmOrderWithOTP(pin);
          setState(() {
            _loading = true;
          });
          Navigator.pop(context);
        },
      );
    } else
      return Container();
  }

  _showOTPDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter OTP"),
            content: Container(
              height: 100.0,
              child: Center(
                child: _loader(setState),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TopText(
          txt: "Order ${widget.order.orderNumber}",
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          widget.order.orderStatus == "Ready"
              ? IconButton(
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                  color: ThemeColoursSeva().lgGreen,
                  onPressed: () {
                    _showOTPDialog();
                  })
              : Container()
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Total Price: Rs ${widget.order.finalItemsPrice}",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          SizedBox(height: 10.0),
          Text("Token: ${widget.order.tokenNumber}",
              style: TextStyle(fontSize: 16.0, color: Colors.black)),
          SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
                itemCount: widget.order.items.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      OrderDetailsCard(
                        item: widget.order.items[index],
                        counter: "${index + 1}",
                      ),
                      SizedBox(
                        height: 10.0,
                      )
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
