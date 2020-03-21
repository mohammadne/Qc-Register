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
              Expanded(
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
                    Consumer<AppProvider>(
                      builder: (_, appProvider, ch) {
                        if (appProvider.sendDataState ==
                            SendDataState.NotPushed) {
                          return RaisedButton(
                            onPressed: () =>
                                Provider.of<AppProvider>(context, listen: false)
                                    .sendData()
                                    .then(
                              (String onresp) {
                                if (onresp != null) {
                                  print(onresp);
                                  return showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          onresp,
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'متوجه شدم',
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                            child: Text("تکمیل ثبت نام و ارسال اطلاعات"),
                          );
                        } else if (appProvider.sendDataState ==
                            SendDataState.Await) {
                          return RaisedButton(
                            onPressed: () {},
                            child: CircularProgressIndicator(),
                          );
                        } else if (appProvider.sendDataState ==
                            SendDataState.Seccess) {
                          return RaisedButton(
                            onPressed: () {},
                            child: Text("عملیات موفقیت آمیز بود"),
                          );
                        } else {
                          return RaisedButton(
                            onPressed: () =>
                                Provider.of<AppProvider>(context, listen: false)
                                    .sendData(),
                            child: Text("تلاش مجدد"),
                          );
                        }
                      },
                    )
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
