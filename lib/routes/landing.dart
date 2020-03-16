import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qc_register/provider/personal.dart';
import 'package:qc_register/provider/workshop.dart';
import 'package:qc_register/routes/Workshop_data.dart';
import 'package:qc_register/routes/personals.dart';
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
                  children: <Widget>[
                    ChangeNotifierProvider(
                      create: (_) => PersonalProvider(),
                      child: PersonalsRoute(),
                    ),
                    Container(
                      padding: CustomPaddings.normalPadding,
                    ),
                    ChangeNotifierProvider(
                      create: (_) => WorkShopProvider(),
                      child: WorkShopDataRoute(),
                    ),
                    Container(
                      padding: CustomPaddings.normalPadding,
                    ),
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
