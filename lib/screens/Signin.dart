import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sevaBusiness/graphics/greenBg.dart';

class Signin extends StatefulWidget {
  Signin({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool showOTPField = false;
  final _mobileFocus = FocusNode();
  final _mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                  style: TextStyle(fontSize: 28.0, color: Colors.blueGrey),
                ),
              ],
            ),
            SizedBox(height: 60.0),
            Padding(
              padding: const EdgeInsets.all(30.0),
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
              padding: const EdgeInsets.only(left: 40.0),
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
                          return ('Need 10 digit numbers');
                        // if (val.length < 10) return 'Need 10 digit numbers';
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen),
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
                                style: TextStyle(fontSize: 24.0),
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
                              Navigator.of(context)
                                  .pushReplacementNamed('/products');
                            },
                            child: Text('Sign IN',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                          )
                          ),
                        )
                      : Container(
                          child: RaisedButton(
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                showOTPField = true;
                              });
                              _mobileFocus.unfocus();
                            }
                          },
                          child: const Text('Get OTP',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        )
                        )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
