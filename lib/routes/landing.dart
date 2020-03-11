import 'package:flutter/material.dart';
import 'package:qc_register/utils/sizing.dart';
import 'package:qc_register/utils/title.dart';

class LandingRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Container(
                padding: CustomPaddings.normalPadding,
                child: TitleUtil(),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
