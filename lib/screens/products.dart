import 'package:flutter/material.dart';
import 'package:sevaBusiness/constants/apiCalls.dart';
import 'package:sevaBusiness/graphics/greenBg.dart';
import 'package:sevaBusiness/models/shopsModel.dart';
import 'package:sevaBusiness/screens/test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products extends StatefulWidget {
  Products({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool showOTPField = false;
  bool _data;
  @override
  void initState() {
    super.initState();
    _data = true;
    _getOrderOfUser();
  }

  _getOrderOfUser() async {
    String url = APIService.getStoreAPI;
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print("worked");
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      // no orders
      setState(() {
        _data = false;
      });
    } else
      throw Exception("Server error");
  }

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
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 100,
                        child: Image.asset('assets/image/orange.png')),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Musambi",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 5),
                          child: Text(
                            "Local",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Rs 200",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "1 kg",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 32,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.grey)),
                      child: RaisedButton(
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Test(),
                            ),
                          );
                        },
                        child: const Text('Edit',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 250.0,
                width: 180,
                decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.grey)),
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 100,
                        child: Image.asset('assets/image/orange.png')),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Musambi",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 5),
                          child: Text(
                            "Local",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Rs 200",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "1 kg",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 32,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.grey)),
                      child: RaisedButton(
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Test(),
                            ),
                          );
                        },
                        child: const Text('Edit',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: _getOrderOfUser(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              List<ShopsModel> shopsArr = snapshot.data;
            }
          }
          )
        ]
        ),
      ),
    );
  }
}
