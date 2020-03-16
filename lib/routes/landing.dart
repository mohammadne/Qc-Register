import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qc_register/provider/app_provider.dart';
import 'package:qc_register/routes/personals.dart';
import 'package:qc_register/utils/sizing.dart';
import 'package:qc_register/utils/title.dart';

import 'Workshop.dart';

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
              ChangeNotifierProvider(
                create: (_) => AppProvider(),
                child: Expanded(
                  child: ListView(
                    children: <Widget>[
                      PersonalsRoute(),
                      Container(
                        padding: CustomPaddings.normalPadding,
                      ),
                      WorkShopRoute(),
                      Container(
                        padding: CustomPaddings.normalPadding,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
