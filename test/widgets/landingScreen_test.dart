import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sevaBusiness/screens/landingScreen.dart';

void main() {
  testWidgets('Landing screen test', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(LandingScreen()));

    final products = find.text('Products');
    final orders = find.text('Orders');

    expect(products, findsOneWidget);
    expect(orders, findsOneWidget);
  });
}

Widget buildTestableWidget(Widget widget) {
  return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
}
