import 'package:flutter/material.dart';
import 'package:sevaBusiness/common/topText.dart';
import 'package:sevaBusiness/models/orders.dart';

class OrderMoreDetails extends StatefulWidget {
  final OrderModel order;
  OrderMoreDetails({this.order});
  @override
  _OrderMoreDetailsState createState() => _OrderMoreDetailsState();
}

class _OrderMoreDetailsState extends State<OrderMoreDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TopText(
          txt: "Order ${widget.order.orderNumber}",
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
