import 'package:flutter/material.dart';

waitingDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: SizedBox(
          width: 40.0,
          height: 40.0,
          child: const CircularProgressIndicator(
            value: null,
            strokeWidth: 2.0,
          ),
        ),
      );
    },
  );
}
