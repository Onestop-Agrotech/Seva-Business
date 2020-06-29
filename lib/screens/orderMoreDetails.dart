import 'package:flutter/material.dart';
import 'package:sevaBusiness/common/orderDetails.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TopText(
          txt: "Order ${widget.order.orderNumber}",
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Total Price: Rs ${widget.order.finalItemsPrice}",style: TextStyle(
            fontSize: 18.0,
            color: Colors.black
          )),
          SizedBox(height: 10.0),
          Text("Token: ${widget.order.tokenNumber}",style: TextStyle(
            fontSize: 16.0,
            color: Colors.black
          )),
          SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
                itemCount: widget.order.items.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      OrderDetailsCard(
                        item: widget.order.items[index],
                        counter: "${index + 1}",
                      ),
                      SizedBox(
                        height: 10.0,
                      )
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
