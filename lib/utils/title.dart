import 'package:flutter/material.dart';
import 'package:qc_register/utils/sizing.dart';

class TitleUtil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: Size.titleHeight,
      decoration: BoxDecoration(
        color: CustomColors.pinkColor,
        borderRadius: CustomBorders.normalBorderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            offset: Offset(5.0, 5.0),
            blurRadius: 15.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset("assets/images/logo.png"),
          Text("ثبت نام کارگاهی")
        ],
      ),
    );
  }
}
