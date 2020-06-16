import 'package:flutter/material.dart';
import 'package:sevaBusiness/constants/apiCalls.dart';
import 'package:sevaBusiness/graphics/greenBg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sevaBusiness/model/shopsModel.dart';

class Products extends StatefulWidget {
  Products({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool showOTPField = false;
  List dataFromDB;
  AllShops shopsModel;

  @override
  void initState() {
    super.initState();
    getOrderOfUser();
  }

  Future<List<AllShops>> getOrderOfUser() async {
    String url = APIService.getStoreAPI;
    var response = await http.get(url);
    var decodedVal = jsonDecode(response.body);
    List<AllShops> dataArray = List<AllShops>();
    decodedVal.forEach((val) {
      dataArray.add(AllShops.fromJson(val));
    });
    shopsModel = AllShops.fromJson(decodedVal);

    return decodedVal;
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomPaint(
        painter: GreenPaintingBgProducts(),
        child: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text("Header 1"),
                    Text("Header 2"),
                    Text("Header 3"),
                    Text("Header 4"),
                  ],
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                delegate: SliverChildListDelegate(
                  [
                    FutureBuilder(
                        future: getOrderOfUser(),
                        builder: (context, snapshot) {
                          return Card();
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
