import 'package:flutter/material.dart';
import 'package:sevaBusiness/classes/storage_sharedPrefs.dart';
import 'package:sevaBusiness/constants/apiCalls.dart';
import 'package:sevaBusiness/constants/themeColors.dart';
import 'package:sevaBusiness/graphics/greenBg.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert';

import 'package:sevaBusiness/models/storeProducts.dart';

class Products extends StatefulWidget {
  Products({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool showOTPField = false;
  // Future<List<StoreProduct>> future;
  List<String> labels = ['Vegetables', 'Fruits'];
  // List<AllProducts> products = List<AllProducts>();
  var categorySelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // future = getProducts();
  }

  Future<List<StoreProduct>> _getProducts() async {
    // products = [];
    // String url = APIService.getStoreAPI;
    // final response = await http.get(url);
    // if (response.statusCode == 200) {
    //   var jsonData = jsonDecode(response.body);
    //   if (jsonData["response"])
    //     for (var i in jsonData["output"]) products.add(AllProducts.fromJson(i));
    // }
    // return products;
    StorageSharedPrefs p = new StorageSharedPrefs();
    String token = await p.getToken();
    String username = await p.getUsername();
    String url = APIService.businessProductsListAPI + "$username/products";
    Map<String, String> requestHeaders = {'x-auth-token': token};
    var response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      return fromJsonToStoreProduct(response.body);
    } else {
      throw Exception('Internal Server error');
    }
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var heightOfScreen = size.longestSide;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: CustomPaint(
        painter: GreenPaintingBgProducts(),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(top: 40),
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
                          hintStyle: TextStyle(color: Colors.black),
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
                        // print("categorySelected" +
                        //     categorySelectedIndex.toString()
                        //     );
                      });
                    },
                    child: Column(
                      children: <Widget>[
                        Text(
                          labels[i],
                          style: TextStyle(
                            fontSize: 20,
                            color: i == categorySelectedIndex
                                ? ThemeColoursSeva().dkGreen
                                : ThemeColoursSeva().vlgGreen,
                            decoration: i == categorySelectedIndex
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
            SizedBox(height: 10),
            FutureBuilder(
              future: _getProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<StoreProduct> arr = snapshot.data;
                  if (arr.length > 0) {
                    return Expanded(
                      child: Scrollbar(
                        child: CustomScrollView(
                          shrinkWrap: true,
                          slivers: <Widget>[
                            SliverGrid(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: heightOfScreen > 700
                                    ? MediaQuery.of(context).size.width /
                                        (MediaQuery.of(context).size.height /
                                            1.4)
                                    : MediaQuery.of(context).size.width /
                                        (MediaQuery.of(context).size.height /
                                            1.2),
                              ),
                              delegate: SliverChildBuilderDelegate(
                                  (context, productIndex) {
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: 180,
                                    // height: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
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
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Text(
                                                arr[productIndex].name,
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
                                                arr[productIndex].description,
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
                                              border: Border.all(
                                                  color: Colors.grey)),
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
                              }, childCount: arr.length),
                            ),
                          ],
                        ),
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
          ],
        ),
      ),
    );
  }
}
