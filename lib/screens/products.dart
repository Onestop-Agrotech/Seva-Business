import 'package:flutter/material.dart';
import 'package:sevaBusiness/classes/storage_sharedPrefs.dart';
import 'package:sevaBusiness/common/Productcard.dart';
import 'package:sevaBusiness/common/topText.dart';
import 'package:sevaBusiness/constants/apiCalls.dart';
import 'package:sevaBusiness/constants/themeColors.dart';
import 'package:http/http.dart' as http;

import 'package:sevaBusiness/models/storeProducts.dart';

class Products extends StatefulWidget {
  Products({Key key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    super.initState();
  }
//

  Future<List<StoreProduct>> _getProducts() async {
    StorageSharedPrefs p = new StorageSharedPrefs();
    String token = await p.getToken();
    String username = await p.getUsername();
    String url = APIService.businessProductsListAPI + "$username/products";
    Map<String, String> requestHeaders = {'x-auth-token': token};
    var response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      return fromJsonToStoreProduct(response.body);
    } else {
      throw Exception('Internal Server error');
    }
  }

  _scrollViewProducts(arr, heightOfScreen) {
    return Expanded(
      child: Scrollbar(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: heightOfScreen > 850
                    ? MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.5)
                    : heightOfScreen > 700
                        ? MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.2)
                        : MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.1),
              ),
              delegate: SliverChildBuilderDelegate((context, productIndex) {
                return Productcard(arr[productIndex]);
              }, childCount: arr.length),
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var heightOfScreen = size.longestSide;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Tab(
              child: Text("Vegetables"),
            ),
            Tab(
              child: Text("Fruits"),
            )
          ]),
          title: TopText(
            txt: 'My Products',
          ),
          leading: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: ThemeColoursSeva().black,
                size: 40.0,
              ),
              onPressed: () {
                // go to store list
                Navigator.pop(context);
              }),
          backgroundColor: Colors.transparent,
          elevation: 0,
          // title: Center(Title: 'My Orders'),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: TabBarView(children: [
          Column(
            children: <Widget>[
              SizedBox(height: 10),
              FutureBuilder(
                future: _getProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<StoreProduct> arr = snapshot.data;
                    arr.sort((a, b) => a.name.compareTo(b.name));
                    arr.removeWhere((element) => element.type == "fruit");
                    if (arr.length > 0) {
                      return _scrollViewProducts(arr, heightOfScreen);
                    } else {
                      return Center(
                        child: Text("No Products Found."),
                      );
                    }
                  } else
                    return Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
          Column(
            children: <Widget>[
              SizedBox(height: 10),
              FutureBuilder(
                future: _getProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<StoreProduct> arr = snapshot.data;
                    arr.sort((a, b) => a.name.compareTo(b.name));
                    arr.removeWhere((element) => element.type == "vegetable");
                    if (arr.length > 0) {
                      return _scrollViewProducts(arr, heightOfScreen);
                    } else {
                      return Center(
                        child: Text("No Products Found."),
                      );
                    }
                  } else
                    return Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
