import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sevaBusiness/constants/themeColors.dart';
import 'package:sevaBusiness/models/storeProducts.dart';

class Productcard extends StatelessWidget {
  final StoreProduct product;
  Productcard(this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 180,
        height: 250,
        child: Column(
          children: <Widget>[
            Container(
              height: 130.0,
              child: CachedNetworkImage(
                imageUrl: product.pictureUrl,
                placeholder: (context, url) =>
                    Container(height: 50.0, child: Text("Loading...")),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    product.name,
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
                    product.description,
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
                  "Rs ${product.price}",
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: ThemeColoursSeva().black),
                ),
                Text(
                  "${product.quantity.quantityValue} ${product.quantity.quantityMetric}",
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: ThemeColoursSeva().black),
                )
              ],
            ),
            SizedBox(height: 16),
            // Container(
            //   height: 32,
            //   width: 80,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(5.0),
            //       border: Border.all(color: Colors.grey)),
            //   child: RaisedButton(
            //     color: Colors.white,
            //     onPressed: () {},
            //     child: const Text('Edit',
            //         style: TextStyle(
            //           fontSize: 15,
            //           color: Colors.black,
            //           fontFamily: "Raleway",
            //         )),
            //   ),
            // )
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
                Text("Mark Out Of Stock", style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey
                ),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
