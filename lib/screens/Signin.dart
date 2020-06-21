import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sevaBusiness/constants/apiCalls.dart';
import 'package:sevaBusiness/constants/themeColors.dart';
import 'package:sevaBusiness/graphics/greenBg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Signin extends StatefulWidget {
  Signin({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool showOTPField = false;
  bool _loading = false;
  final _mobileFocus = FocusNode();
  final _mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _showLoader() {
    if (_loading) {
      return CircularProgressIndicator();
    } else
      return showOTPField
          ? Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                  child: RaisedButton(
                color: ThemeColoursSeva().dkGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/products');
                },
                child: Text('Sign IN',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "Raleway",
                    )),
              )),
            )
          : Container(
              child: RaisedButton(
              color: ThemeColoursSeva().dkGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _mobileFocus.unfocus();
                  setState(() {
                    _loading = true;
                  });

                  // Here submit the form
                  await _verifyMobile();
                }
              },
              child: const Text('Get OTP',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: "Raleway",
                  )),
            ));
  }

  _verifyMobile() async {
    var getJson = json.encode({"phone": _mobileController.text});
    String url = APIService.loginMobile;
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http.post(url, body: getJson, headers: headers);
    if (response.statusCode == 200) {
      // successfully verified phone number
      setState(() {
        _loading = false;
        showOTPField = true;
      });
    } else if (response.statusCode == 404) {
      // throw error, phone number not registered
      setState(() {
        _loading = false;
      });
    } else if (response.statusCode == 500) {
      // throw error, internal server error
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomPaint(
        painter: GreenPaintBgLogin(),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: ThemeColoursSeva().dkGreen,
                    fontFamily: "Raleway",
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "S",
                    style: TextStyle(
                      fontSize: 40.0,
                      color: ThemeColoursSeva().lgGreen,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Raleway",
                    ),
                  ),
                  Text(
                    "eva",
                    style: TextStyle(
                      fontSize: 30.0,
                      color: ThemeColoursSeva().lgGreen,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Raleway",
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "B",
                    style: TextStyle(
                      fontSize: 40.0,
                      color: ThemeColoursSeva().lgGreen,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Raleway",
                    ),
                  ),
                  Text("usiness",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: ThemeColoursSeva().lgGreen,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Raleway",
                      ))
                ],
              ),
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Mobile:",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontFamily: "Raleway",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 260,
                    child: TextFormField(
                      enableInteractiveSelection: true,
                      textInputAction: TextInputAction.next,
                      autofocus: false,
                      focusNode: _mobileFocus,
                      keyboardType: TextInputType.number,
                      controller: _mobileController,

                      validator: (String val) {
                        if (val.isEmpty || val.length < 10)
                          return ('Min 10 digit number required!');
                        else
                          return (null);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ThemeColoursSeva().dkGreen),
                            borderRadius: BorderRadius.circular(10)),
                        labelText: '+91',
                      ),
                      maxLength: 10,
                      // onTap: ,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  showOTPField
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: Text(
                                "Enter OTP:",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontFamily: "Raleway",
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 100),
                              child: OTPTextField(
                                length: 6,
                                width: MediaQuery.of(context).size.width,
                                fieldWidth: 30,
                                style: TextStyle(fontSize: 20),
                                textFieldAlignment:
                                    MainAxisAlignment.spaceAround,
                                fieldStyle: FieldStyle.underline,
                                onCompleted: (pin) {},
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                      _showLoader()
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
