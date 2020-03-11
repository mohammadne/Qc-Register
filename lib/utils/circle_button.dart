import 'package:flutter/material.dart';
import 'package:qc_register/utils/sizing.dart';

import 'gradient_border.dart';

class CircleButtonUtil extends StatelessWidget {
  final String text;
  final Function onPressed;
  CircleButtonUtil({
    @required this.text,
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColors.pinkColor,
              ),
              child: UnicornOutlineButton(
                strokeWidth: 3,
                radius: 100,
                gradient: CustomGradient.gradient,
                child: Container(),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
