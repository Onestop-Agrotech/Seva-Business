// import 'package:flutter/material.dart';
// import 'package:sevaBusiness/constants/apiCalls.dart';
// import 'package:sevaBusiness/graphics/greenBg.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:sevaBusiness/model/productsModel.dart';

// class Test extends StatefulWidget {
//   Test({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _TestState createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   bool showOTPField = false;
//   AllProducts shopsModel;

//   @override
//   void initState() {
//     super.initState();
//     getOrderOfUser();
//   }

//   getOrderOfUser() async {
//     String url = APIService.getStoreAPI;
//     var response = await http.get(url);
//     var decodedVal = jsonDecode(response.body);
//     shopsModel = AllProducts.fromJson(decodedVal);
//     setState(() {});
//   }

//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     /*24 is for notification bar on Android*/
//     final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
//     final double itemWidth = size.width / 2;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: CustomPaint(
//           painter: GreenPaintingBgProducts(),
//           child: Column(
//             children: <Widget>[
//               SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.only(top: 60),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       "My Products",
//                       style: TextStyle(fontSize: 25.0, color: Colors.blueGrey),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(40.0),
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                         child: Container(
//                       height: 50.0,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(15.0),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 20),
//                         child: TextField(
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Search...",
//                             hintStyle: TextStyle(color: Colors.black),
//                           ),
//                           style: TextStyle(color: Colors.black, fontSize: 20),
//                         ),
//                       ),
//                     )),
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   Column(
//                     children: <Widget>[
//                       Text(
//                         "Vegetables",
//                         style: TextStyle(fontSize: 20),
//                       ),
//                       SizedBox(height: 10),
//                       Icon(
//                         Icons.lens,
//                       )
//                     ],
//                   ),
//                   Column(
//                     children: <Widget>[
//                       Text(
//                         "Fruits",
//                         style: TextStyle(fontSize: 20),
//                       ),
//                       SizedBox(height: 10),
//                       Icon(
//                         Icons.lens,
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//               // SizedBox(height:10),
//               shopsModel == null
//                   ? Center(child: CircularProgressIndicator())
//                   : Expanded(
//                       child: GridView.count(
//                         shrinkWrap: true,
//                         childAspectRatio: (itemWidth / itemHeight),
//                         crossAxisCount: 2,
//                         children: shopsModel.output
//                             .map((poke) => Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Container(
//                               width: 180,

//                               // height: double.infinity,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15.0),
//                                   border: Border.all(color: Colors.grey)),
//                               child: Column(
//                                 children: <Widget>[
//                                   Container(
//                                       width: 100,
//                                       child: Image.asset(
//                                           'assets/image/orange.png')),
//                                   Row(
//                                     children: <Widget>[
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 20),
//                                         child: Text(
//                                           "snapshot.data[productIndex].username",
//                                           style: TextStyle(
//                                             fontSize: 20,
//                                             fontFamily: "Raleway",
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 20, top: 5),
//                                         child: Text(
//                                          " snapshot.data[productIndex].city",
//                                           style: TextStyle(
//                                             fontSize: 15,
//                                             fontFamily: "Raleway",
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 20.0),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     children: <Widget>[
//                                       Text(
//                                         "Rs 200",
//                                         style: TextStyle(
//                                           fontSize: 20,
//                                           fontFamily: "Raleway",
//                                         ),
//                                       ),
//                                       Text(
//                                         "1 kg",
//                                         style: TextStyle(
//                                           fontSize: 20,
//                                           fontFamily: "Raleway",
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   SizedBox(height: 16),
//                                   Container(
//                                     height: 32,
//                                     width: 80,
//                                     decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(5.0),
//                                         border: Border.all(color: Colors.grey)),
//                                     child: RaisedButton(
//                                       color: Colors.white,
//                                       onPressed: () {},
//                                       child: const Text('Edit',
//                                           style: TextStyle(
//                                             fontSize: 15,
//                                             color: Colors.black,
//                                             fontFamily: "Raleway",
//                                           )),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           )
//                                 )
//                             .toList(),
//                       ),
//                     )
//             ],
//           )),
//     );
//   }
// }
