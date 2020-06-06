import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool showOTPField = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Sign In",
                      style: TextStyle(fontSize: 28.0, color: Colors.blueGrey),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "S",
                        style: TextStyle(
                            fontSize: 45.0,
                            color: Colors.green,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "eva",
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.green,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "B",
                        style: TextStyle(
                            fontSize: 45.0,
                            color: Colors.green,
                            fontWeight: FontWeight.w500),
                      ),
                      Text("usiness",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.green,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(left: 70.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Mobile:",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: 270,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightGreen),
                          borderRadius: BorderRadius.circular(10)),
                      labelText: '+91',
                    ),
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    // onTap: ,
                  ),
                ),
                SizedBox(height: 10.0),
                showOTPField
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 70.0),
                            child: Text(
                              "Enter OTP:",
                              style: TextStyle(fontSize: 24.0),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 60, right: 100),
                            child: OTPTextField(
                              length: 6,
                              width: MediaQuery.of(context).size.width,
                              fieldWidth: 30,
                              style: TextStyle(fontSize: 20),
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldStyle: FieldStyle.underline,
                              onCompleted: (pin) {
                                print("Completed: " + pin);
                              },
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
                showOTPField
                    ? Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Container(
                            child: RaisedButton(
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          onPressed: () {
                            setState(() {
                              showOTPField = true;
                            });
                          },
                          child: const Text('Sign IN',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        )),
                      )
                    : Container(
                        child: RaisedButton(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {
                          setState(() {
                            showOTPField = true;
                          });
                        },
                        child: const Text('Get OTP',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ))
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
