import 'package:flutter/material.dart';

import './screens/homePage.dart';
import './screens/exchange_rate_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: MyHomePage(),
      routes: {
        MyHomePage.routeName: (ctx) => MyHomePage(),
        ExchangeRate.routeName: (ctx) => ExchangeRate(),
      },
    );
  }
}
