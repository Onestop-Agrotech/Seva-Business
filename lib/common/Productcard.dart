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
  bool _loaderSwitch;

  @override
  initState() {
    super.initState();
    _loaderSwitch = false;
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
      setState(() {
        _loaderSwitch = false;
      });
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
            title: Text('Edit Price and Quantity'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("Price"),
                    Text("Rs ${product.price}")
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("Quantity"),
                    Text("${product.quantity.quantityValue}")
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("Value"),
                    Text("${product.quantity.quantityMetric}")
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Edit")),
            ],
          );
        });
  }

  _showLoaderForStockSwitch() {
    if (!_loaderSwitch)
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Switch(
            value: widget.product.outOfStock ? true : false,
            onChanged: (val) {
              // do something here
              setState(() {
                _loaderSwitch = true;
              });
              _markOutOfStock();
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
          Text(
            widget.product.outOfStock ? "Mark In Stock" : "Mark Out Of Stock",
            style: TextStyle(fontSize: 10.0, color: Colors.grey),
          )
        ],
      );
    else
      return CircularProgressIndicator();
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
            _showLoaderForStockSwitch(),
          ],
        ),
      ),
    );
  }
}
