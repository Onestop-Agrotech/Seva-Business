import 'package:flutter/material.dart';
import 'package:sevaBusiness/constants/themeColors.dart';
import 'package:sevaBusiness/models/orders.dart';
import 'package:sevaBusiness/screens/orderMoreDetails.dart';

class CustomOrdersCard extends StatefulWidget {
  final OrderModel order;

  CustomOrdersCard({this.order});
  @override
  _CustomOrdersCardState createState() => _CustomOrdersCardState();
}

class _CustomOrdersCardState extends State<CustomOrdersCard> {
  var _time;
  bool _less = false;

  @override
  void initState() {
    super.initState();
    _time = DateTime.parse(widget.order.timestamp.toString()).toLocal();
    if (int.parse(_time.minute.toString()) < 10)
      setState(() {
        _less = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.0,
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "No. ${widget.order.orderNumber}",
                style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: ThemeColoursSeva().black),
              ),
              Row(
                children: <Widget>[
                  Text(
                    "${_time.day}/${_time.month}/${_time.year}",
                    style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 14.0,
                        color: ThemeColoursSeva().black),
                  ),
                  SizedBox(width: 10.0),
                  _less
                      ? Text("${_time.hour}:0${_time.minute}",
                          style: TextStyle(
                              fontFamily: "Raleway",
                              fontSize: 14.0,
                              color: ThemeColoursSeva().black))
                      : Text("${_time.hour}:${_time.minute}",
                          style: TextStyle(
                              fontFamily: "Raleway",
                              fontSize: 14.0,
                              color: ThemeColoursSeva().black)),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Switch(
                    value:
                        widget.order.orderStatus == "Processing" ? false : true,
                    onChanged: (val) {
                      // change order status here
                      setState(() {
                        // widget.order.orderStatus="Ready";
                        if (widget.order.orderStatus == "Processing")
                          widget.order.orderStatus = "Ready";
                        else
                          widget.order.orderStatus = "Processing";
                      });
                      // send POST request to server here
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  ),
                  Text(
                    widget.order.orderStatus == "Processing"
                        ? "Mark as PACKED"
                        : "PACKED",
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  )
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "T ${widget.order.tokenNumber}",
                style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: ThemeColoursSeva().black),
              ),
              SizedBox(height: 10.0),
              Text("${widget.order.orderStatus}",
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 17.0,
                      color: Colors.deepOrange)),
              SizedBox(height: 10.0),
              FlatButton(
                shape: Border.all(width: 0.2),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderMoreDetails(
                          order: widget.order,
                        ),
                      ));
                },
                child: Text("More Details",
                    style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 14.0,
                    )),
                textColor: ThemeColoursSeva().dkGreen,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
