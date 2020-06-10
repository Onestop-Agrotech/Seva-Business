import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sevaBusiness/graphics/greenBg.dart';
import 'package:sevaBusiness/screens/products.dart';
import 'package:sevaBusiness/screens/test.dart';

class Signin extends StatefulWidget {
  Signin({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool showOTPField = false;
  final FocusNode _mobileFocus = FocusNode();
  final TextEditingController _mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomPaint(
        painter: GreenPaintBgLogin(),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
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
              Column(
                children: <Widget>[
                  Container(
                    width: 260,
                    child: TextFormField(
                      enableInteractiveSelection: true,
                      textInputAction: TextInputAction.next,
                      autofocus: false,
                      focusNode: _mobileFocus,
                      keyboardType: TextInputType.number,

                      validator: (String val) {
                        if (val.isEmpty) return 'MObile  cannot be empty';
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
                ],
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
                          padding: const EdgeInsets.only(left: 40, right: 100),
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
                  ? Column(
                      children: <Widget>[
                        Padding(
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
                          )),
                        ),
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        Container(
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
                        )),
                      ],
                    )
            ]),
          ),
        ),
      ),
    );
  }
}
