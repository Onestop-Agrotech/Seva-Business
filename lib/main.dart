import 'package:flutter/material.dart';
import 'package:sevaBusiness/screens/landingScreen.dart';
import 'package:sevaBusiness/screens/loadingScreen.dart';
import 'package:sevaBusiness/screens/orders.dart';
import 'package:sevaBusiness/screens/login.dart';
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
      initialRoute: '/loading',
      routes: {
        '/signIn': (context) => Signin(),
        '/loading': (context) => LoadingScreen(),
        '/landing': (context) => LandingScreen(),
        '/products': (context) => Products(),
        '/orders': (context) => OrdersScreen()
      },
    );
  }
}
