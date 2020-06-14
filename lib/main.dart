import 'package:flutter/material.dart';
import 'package:sevaBusiness/screens/Signin.dart';
import 'package:sevaBusiness/screens/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seva Business',
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3EBACE),
        accentColor: Color(0xFFD8ECF1),
        scaffoldBackgroundColor: Color(0xFFF3F5F7),
      ),
   initialRoute: '/',
        routes: {
          '/': (context) => Signin(),
          '/products': (context) => Products(),
        },
            );
  }
}