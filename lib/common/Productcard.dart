import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sevaBusiness/classes/storage_sharedPrefs.dart';
import 'package:sevaBusiness/constants/themeColors.dart';
import 'package:sevaBusiness/models/storeProducts.dart';
import 'package:http/http.dart' as http;

class Productcard extends StatefulWidget {
  final StoreProduct product;
  Productcard(this.product);

  @override
  _ProductcardState createState() => _ProductcardState();
}

class _ProductcardState extends State<Productcard> {
  TextEditingController price = new TextEditingController();
  TextEditingController qty = new TextEditingController();
  TextEditingController qtyVal = new TextEditingController();
  String dropdownValue;

  bool _loadingEdit = false;

  @override
  initState() {
    super.initState();
    dropdownValue = widget.product.quantity.quantityMetric;
  }

  _showLoaderEdit(setState) {
    if (_loadingEdit) {
      return CircularProgressIndicator();
    } else {
      return Row(
        children: <Widget>[
          RaisedButton(
              textColor: Colors.white,
              color: Colors.green,
              onPressed: () async {
                setState(() {
                  _loadingEdit = true;
                });
                await _updateProduct();
                Navigator.pop(context);
              },
              child: Text(
                "Edit",
                style: TextStyle(fontSize: 20.0),
              )),
          SizedBox(width: 30.0),
          RaisedButton(
            textColor: Colors.white,
            color: Colors.red,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      );
    }
  }

  _updateProduct() async {
    StorageSharedPrefs p = new StorageSharedPrefs();
    String username = await p.getUsername();
    String token = await p.getToken();
    String priceURL =
        "https://api.theonestop.co.in/api/businesses/$username/product/${widget.product.name}/price";
    String qURL =
        "https://api.theonestop.co.in/api/businesses/$username/product/${widget.product.name}/qty";
    Map<String, String> requestHeaders = {'x-auth-token': token};
    if (price.text != "" && price.text != null) {
      // update price here
      var jBody = json.encode({"price": price.text});
      var response =
          await http.put(priceURL, headers: requestHeaders, body: jBody);
      if (response.statusCode == 200) {
        // successfully toggled Out Of Stock
        print("success");
        setState(() {
          widget.product.price = int.parse(price.text);
          _loadingEdit = false;
        });
        price.clear();
      } else if (response.statusCode == 404) {
        // no business user found
        print("404 error");
      } else if (response.statusCode == 500) {
        // internal server error
        print("500 error");
      } else {
        // throw some error exception
        print("some other error");
      }
    }
    if ((qty.text != "" && qty.text != null) || dropdownValue.length > 0) {
      // update the quantity
      var jBody = json.encode({
        "quantityValue": (qty.text != "" && qty.text != null)
            ? qty.text
            : widget.product.quantity.quantityValue,
        "quantityMetric": dropdownValue
      });
      var response = await http.put(qURL, headers: requestHeaders, body: jBody);
      if (response.statusCode == 200) {
        // successfully toggled Out Of Stock
        print("success");
        setState(() {
          if (qty.text != "" && qty.text != null)
            widget.product.quantity.quantityValue = int.parse(qty.text);
          widget.product.quantity.quantityMetric = dropdownValue;
          _loadingEdit = false;
        });
        qty.clear();
      } else if (response.statusCode == 404) {
        // no business user found
        print("404 error");
      } else if (response.statusCode == 500) {
        // internal server error
        print("500 error");
      } else {
        // throw some error exception
        print("some other error");
      }
    }
  }

  _markOutOfStock() async {
    StorageSharedPrefs p = new StorageSharedPrefs();
    String username = await p.getUsername();
    String token = await p.getToken();
    String url =
        "https://api.theonestop.co.in/api/businesses/$username/${widget.product.name}/out-of-stock";
    Map<String, String> requestHeaders = {'x-auth-token': token};
    var response = await http.post(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      // successfully toggled Out Of Stock
      print("success");
    } else if (response.statusCode == 404) {
      // no business user found
      print("404 error");
    } else if (response.statusCode == 500) {
      // internal server error
      print("500 error");
    } else {
      // throw some error exception
      print("some other error");
    }
  }

  _showEditOptions(context, product) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit ${product.name}'),
            content: StatefulBuilder(builder: (context, setState) {
              // dropdownValue = widget.product.quantity.quantityMetric;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Price"),
                      Container(
                        width: 30.0,
                        height: 50.0,
                        child: TextFormField(
                          decoration:
                              InputDecoration(labelText: '${product.price}'),
                          controller: price,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Quantity"),
                      Container(
                        width: 30.0,
                        height: 50.0,
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: '${product.quantity.quantityValue}'),
                          controller: qty,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Value"),
                      DropdownButton(
                        value: dropdownValue,
                        items: <String>[
                          'Kg',
                          'Kgs',
                          'Gm',
                          'Gms',
                          'Pc',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                      )
                    ],
                  ),
                ],
              );
            }),
            actions: <Widget>[
              StatefulBuilder(builder: (context, setState) {
                return _showLoaderEdit(setState);
              })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 180,
        height: 250,
        child: Column(
          children: <Widget>[
            Material(
              child: InkWell(
                onTap: () {
                  _showEditOptions(context, widget.product);
                },
                child: Container(
                  height: 130.0,
                  child: CachedNetworkImage(
                    imageUrl: widget.product.pictureUrl,
                    placeholder: (context, url) =>
                        Container(height: 50.0, child: Text("Loading...")),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    widget.product.name,
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: ThemeColoursSeva().black),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Text(
                    widget.product.description,
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                        color: ThemeColoursSeva().grey),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "Rs ${widget.product.price}",
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: ThemeColoursSeva().black),
                ),
                Text(
                  "${widget.product.quantity.quantityValue} ${widget.product.quantity.quantityMetric}",
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: ThemeColoursSeva().black),
                )
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Switch(
                  value: !widget.product.outOfStock ? true : false,
                  onChanged: (val) {
                    // do something here
                    setState(() {
                      // _loaderSwitch = true;
                      widget.product.outOfStock = !val;
                    });
                    _markOutOfStock();
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
                Text(
                  !widget.product.outOfStock ? "In Stock" : "Out Of Stock",
                  style: TextStyle(fontSize: 10.0, color: Colors.grey),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
