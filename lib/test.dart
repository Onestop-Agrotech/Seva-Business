import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sevaBusiness/greenBg.dart';
import 'package:sevaBusiness/products.dart';

class Test extends StatefulWidget {
  Test({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  bool showOTPField = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomPaint(
        painter: GreenPaintingBgProducts(),
        child: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "My Products",
                  style: TextStyle(fontSize: 25.0, color: Colors.blueGrey),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Search...",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Vegetables",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Icon(
                    Icons.lens,
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    "Fruits",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Icon(
                    Icons.lens,
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 250.0,
                width: 180,
                decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.grey)),
              ),
              Container(
                height: 250.0,
                width: 180,
                decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.grey)),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
