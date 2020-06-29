import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sevaBusiness/constants/themeColors.dart';
import 'package:sevaBusiness/models/orders.dart';

class OrderDetailsCard extends StatelessWidget {
  final Item item;
  final String counter;
  OrderDetailsCard({this.item, this.counter});
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text("$counter."),
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
            Text(
              "${item.name}",
              style:
                  TextStyle(color: ThemeColoursSeva().dkGreen, fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text("Rs ${item.totalPrice}",
                style: TextStyle(
                    color: ThemeColoursSeva().dkGreen, fontSize: 18.0)),
            SizedBox(height: 10.0),
            Text("${item.quantity.quantityValue} ${item.quantity.quantityMetric}    x${item.totalQuantity}",
                style: TextStyle(
                    color: ThemeColoursSeva().dkGreen, fontSize: 18.0))
          ],
        ),
      ],
    );
  }
}
