import 'package:flutter/material.dart';
import 'package:qc_register/routes/landing.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "IranSans"
      ),
      home: LandingRoute(),
    );
  }
}
