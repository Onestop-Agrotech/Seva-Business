import 'package:flutter/material.dart';
import 'package:sevaBusiness/constants/apiCalls.dart';
import 'package:sevaBusiness/constants/themeColors.dart';
import 'package:sevaBusiness/graphics/greenBg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sevaBusiness/model/shopsModel.dart';

class Products extends StatefulWidget {
  Products({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool showOTPField = false;
  var future;
  List<String> labels = ['Vegetables', 'Fruits'];

//   final fruitList = ['apple', 'orange', 'mango'];
// final fruitMap = fruitList.asMap();

  @override
  void initState() {
    super.initState();
    future = getProducts();
  }

  List<AllProducts> products = List<AllProducts>();
  var categorySelectedIndex = 0;

  Future<List<AllProducts>> getProducts() async {
    products = [];
    String url = APIService.getStoreAPI;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["response"])
        for (var i in jsonData["output"]) products.add(AllProducts.fromJson(i));
    }
    return products;
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomPaint(
        painter: GreenPaintingBgProducts(),
        child: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                return Scrollbar(
                  child: CustomScrollView(
                    // shrinkWrap: true,
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(top: 60),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "My Products",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      color: ThemeColoursSeva().dkGreen,
                                      fontFamily: "Raleway",
                                    ),
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
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Search...",
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                        ),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: "Raleway",
                                        ),
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                for (int i = 0; i < labels.length; i++)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        categorySelectedIndex = i;
                                        print("categorySelected" +
                                            categorySelectedIndex.toString());
                                      });
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          labels[i],
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: i == categorySelectedIndex
                                                ?  ThemeColoursSeva().dkGreen
                                                :  ThemeColoursSeva().vlgGreen,
                                            decoration:
                                                i == categorySelectedIndex
                                                    ? TextDecoration.underline
                                                    : TextDecoration.none,
                                            fontFamily: "Raleway",
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Icon(
                                          Icons.lens,
                                          color: i == categorySelectedIndex
                                              ? Colors.black
                                              : Colors.grey,
                                        )
                                      ],
                                    ),
                                  )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: (itemWidth / itemHeight),
                        ),
                        delegate:
                            SliverChildBuilderDelegate((context, productIndex) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              width: 180,

                              // height: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(color: Colors.grey)),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      width: 100,
                                      child: Image.asset(
                                          'assets/image/orange.png')),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          snapshot.data[productIndex].username,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Raleway",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, top: 5),
                                        child: Text(
                                          snapshot.data[productIndex].city,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Raleway",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        "Rs 200",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "Raleway",
                                        ),
                                      ),
                                      Text(
                                        "1 kg",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "Raleway",
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Container(
                                    height: 32,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(color: Colors.grey)),
                                    child: RaisedButton(
                                      color: Colors.white,
                                      onPressed: () {},
                                      child: const Text('Edit',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontFamily: "Raleway",
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }, childCount: snapshot.data.length),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text("No Shops Found"),
                );
              }
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
