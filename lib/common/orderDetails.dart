import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OrderDetailsCard extends StatelessWidget {
  final String pURL;
  OrderDetailsCard({this.pURL});
  Widget build(BuildContext context) {
    return Container(
      height: 130.0,
      child: CachedNetworkImage(
        imageUrl: pURL,
        placeholder: (context, url) =>
            Container(height: 50.0, child: Text("Loading...")),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
