import 'package:flutter/material.dart';
import 'package:qc_register/utils/sizing.dart';

import 'gradient_border.dart';

class TitleUtil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: CustomSize.titleHeight,
      decoration: BoxDecoration(
        borderRadius: CustomBorders.normalBorderRadius,
        color: CustomColors.pinkColor,
      ),
      child: UnicornOutlineButton(
        strokeWidth: 3,
        radius: 10,
        gradient: CustomGradient.gradient,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                borderRadius: CustomBorders.normalBorderRadius,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(0.2),
                  ],
                  stops: [0.6, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          offset: Offset(5.0, 5.0),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  Text(
                    "ثبت نام کارگاهی",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
