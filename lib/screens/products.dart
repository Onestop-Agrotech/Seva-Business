import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sevaBusiness/classes/storage_sharedPrefs.dart';
import 'package:sevaBusiness/constants/apiCalls.dart';
import 'package:sevaBusiness/constants/themeColors.dart';
import 'package:sevaBusiness/graphics/greenBg.dart';
import 'package:http/http.dart' as http;

import 'package:sevaBusiness/models/storeProducts.dart';

class Products extends StatefulWidget {
  Products({Key key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<String> _labels;
  int _categorySelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _labels = ['Vegetables', 'Fruits'];
  }
//

  Future<List<StoreProduct>> _getProducts() async {
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
                      fontSize: 16.0,
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
                    height: 40.0,
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
                          fontSize: 15,
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
                for (int i = 0; i < _labels.length; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _categorySelectedIndex = i;
                      });
                    },
                    child: Column(
                      children: <Widget>[
                        Text(
                          _labels[i],
                          style: TextStyle(
                            fontSize: 16.5,
                            color: i == _categorySelectedIndex
                                ? ThemeColoursSeva().dkGreen
                                : ThemeColoursSeva().vlgGreen,
                            decoration: i == _categorySelectedIndex
                                ? TextDecoration.underline
                                : TextDecoration.none,
                            fontFamily: "Raleway",
                          ),
                        ),
                        SizedBox(height: 10),
                        Icon(
                          Icons.lens,
                          color: i == _categorySelectedIndex
                              ? Colors.black
                              : Colors.grey,
                          size: 15.0,
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
                                            1.2)
                                    : MediaQuery.of(context).size.width /
                                        (MediaQuery.of(context).size.height /
                                            1.1),
                              ),
                              delegate: SliverChildBuilderDelegate(
                                  (context, productIndex) {
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: 180,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        border: Border.all(color: Colors.grey)),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 130.0,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                arr[productIndex].pictureUrl,
                                            placeholder: (context, url) =>
                                                Container(
                                                    height: 50.0,
                                                    child: Text("Loading...")),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Text(
                                                arr[productIndex].name,
                                                style: TextStyle(
                                                    fontFamily: 'Raleway',
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: ThemeColoursSeva()
                                                        .black),
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
                                                    fontFamily: 'Raleway',
                                                    fontSize: 10.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: ThemeColoursSeva()
                                                        .grey),
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
                                              "Rs ${arr[productIndex].price}",
                                              style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      ThemeColoursSeva().black),
                                            ),
                                            Text(
                                              "${arr[productIndex].quantity.quantityValue} ${arr[productIndex].quantity.quantityMetric}",
                                              style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      ThemeColoursSeva().black),
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
