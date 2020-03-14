import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future showErrorDialog(
    {@required BuildContext context, @required String massage}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(
          massage,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.body1,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('متوجه شدم',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle),
          )
        ],
      );
    },
  );
}
