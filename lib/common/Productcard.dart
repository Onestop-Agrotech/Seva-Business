import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sevaBusiness/constants/themeColors.dart';
import 'package:sevaBusiness/models/storeProducts.dart';

class Productcard extends StatefulWidget {
  final StoreProduct product;
  Productcard(this.product);

  @override
  _ProductcardState createState() => _ProductcardState();
}

class _ProductcardState extends State<Productcard> {
  _showEditOptions(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Price and Quantity'),
            content: Text('You will edit here.'),
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
                  _showEditOptions(context);
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
                  value: false,
                  onChanged: (val) {
                    // do something here
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
                Text(
                  "Mark Out Of Stock",
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
