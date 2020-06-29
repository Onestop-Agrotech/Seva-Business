import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sevaBusiness/models/orders.dart';

class OrderDetailsCard extends StatelessWidget {
  final Item item;
  OrderDetailsCard({this.item});
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 130.0,
          width: 120.0,
          child: CachedNetworkImage(
            imageUrl: item.itemPictureURL,
            placeholder: (context, url) =>
                Container(height: 50.0, child: Text("Loading...")),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        Column(
          children: <Widget>[
            Text("${item.name}"),
            SizedBox(height: 10.0),
            Text("Rs ${item.totalPrice}"),
            SizedBox(height: 10.0),
            Text("Qty x${item.totalQuantity}")
          ],
        ),
      ],
    );
  }
}
