import 'package:flutter/material.dart';
import 'PriceScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.blue,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.black,
              ),
          scaffoldBackgroundColor: Colors.white),
      home: PriceScreen(),
    );
  }
}
