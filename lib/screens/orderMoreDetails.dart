import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sevaBusiness/common/orderDetails.dart';
import 'package:sevaBusiness/common/topText.dart';
import 'package:sevaBusiness/constants/themeColors.dart';
import 'package:sevaBusiness/models/orders.dart';

class OrderMoreDetails extends StatefulWidget {
  final OrderModel order;
  OrderMoreDetails({this.order});
  @override
  _OrderMoreDetailsState createState() => _OrderMoreDetailsState();
}

class _OrderMoreDetailsState extends State<OrderMoreDetails> {
  _showOTPField() {
    if (widget.order.orderStatus == "Ready") {
      return Container(
        color: Colors.white,
        height: 100.0,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Enter OTP:",
                style: TextStyle(
                    fontSize: 15.0,
                    color: ThemeColoursSeva().dkGreen,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 30,
                style: TextStyle(fontSize: 20),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {},
              ),
            )
          ],
        ),
      );
    } else
      return Container();
  }

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
          Text("Total Price: Rs ${widget.order.finalItemsPrice}",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          SizedBox(height: 10.0),
          Text("Token: ${widget.order.tokenNumber}",
              style: TextStyle(fontSize: 16.0, color: Colors.black)),
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
      floatingActionButton: _showOTPField(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
