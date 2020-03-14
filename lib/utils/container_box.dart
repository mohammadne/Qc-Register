import 'package:flutter/material.dart';
import 'package:qc_register/utils/sizing.dart';

import 'gradient_border.dart';

class ContainerBox extends StatelessWidget {
  ContainerBox({@required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: CustomPaddings.smallPadding,
      decoration: BoxDecoration(
        borderRadius: CustomBorders.normalBorderRadius,
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade400,
            Colors.white,
          ],
          stops: [0.0, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: UnicornOutlineButton(
          strokeWidth: 3,
          radius: 10,
          gradient: CustomGradient.gradient,
          height: children.length * CustomSize.itemSizes,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          )
          // child: ListView(
          //   physics: NeverScrollableScrollPhysics(),
          //   shrinkWrap: true,
          //   children: children,
          // ),
          ),
    );
  }
}
